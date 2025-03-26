//
//  GuaranteeMainQueue.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import Foundation

class GuaranteeMainQueue<T> {
  var object: T
  
  init(_ object: T) {
    self.object = object
    
  }
  
}

extension GuaranteeMainQueue: ImageLoader where T: ImageLoader {
  func loadImage(from url: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
    object.loadImage(from: url, completion: { result in
      guaranteeMainThread {
        completion(result)
      }
    })
  }
  
}

func guaranteeMainThread(work: @escaping () -> Void) {
    if Thread.isMainThread {
        work()
        
    }else {
        DispatchQueue.main.async(execute: work)
    }
    
}
