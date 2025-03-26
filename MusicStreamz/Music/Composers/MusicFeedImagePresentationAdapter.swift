//
//  MusicFeedImagePresentationAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 28/06/23.
//

import Foundation

final class MusicFeedImagePresentationAdapter: MusicFeedImageLoadingDelegate {
  func didCancelRequest() {
    task?.cancel()
  }
  
  var presenter: MusicFeedImagePresenter?
  
  private let imageLoader: ImageLoader
  private let url: String
  private var task: URLSessionDataTask?
  
  init(url: String, imageLoader: ImageLoader) {
    self.imageLoader = imageLoader
    self.url = url
  }
  
  func didRequestImage() {
    presenter?.didStartLoading()
    
    task = imageLoader.loadImage(from: url) { [weak self] result in
      switch result {
      case .success(let data):
        self?.presenter?.didFinishLoading(with: data)
        
      case .failure(let error):
        self?.presenter?.didFinishLoading(with: error)
      }
    }
    
  }
  
}
