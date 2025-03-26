//
//  ImageLoadingServiceAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import Foundation

class ImageLoadingServiceAdapter: ImageLoader {
  
  func loadImage(
    from url: String,
    completion: @escaping (Result<Data, Error>) -> Void
  ) -> URLSessionDataTask? {
    var dataTask: URLSessionDataTask?

    guard let URL = URL(string: url) else {
      completion(.failure(NSError(domain: "Failed to create URL Request", code: 0)))
      return dataTask
    }
    
    let urlRequest = URLRequest(url: URL)
    dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
        completion(.failure(NSError(domain: "Unknown response from server", code: 0)))
        return
      }
      
      if let error {
        completion(.failure(error))
        return
      }
      
      if let data {
        LocalCacheManager.imageCache.setObject(data as NSData, forKey: NSString(string: url))
        completion(.success(data))
      }
      
    }
    
    dataTask?.resume()
    
    return dataTask
  }
  
}

class LocalImageLoader: ImageLoader {
  
  func loadImage(from url: String,
                 completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
    
    if let data = LocalCacheManager.imageCache.object(forKey: NSString(string: url)) as? Data {
      completion(.success(data))
      return nil
    }
    
    completion(.failure(NSError(domain: "Failed to load image from URL, \(url)", code: 0)))
    return nil
    
  }
  
}

class ImageLoaderComposite: ImageLoader {
  let primary: ImageLoader
  let fallback: ImageLoader
  
  init(primary: ImageLoader, fallback: ImageLoader) {
    self.primary = primary
    self.fallback = fallback
  }
  
  func loadImage(from url: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
    var task: URLSessionDataTask?
    
    task = primary.loadImage(from: url) { [weak self] result in
      switch result {
      case .success:
        completion(result)
        
      case .failure:
        task = self?.fallback.loadImage(from: url, completion: completion)
        
      }
    }
    
    return task
  }
  
}
