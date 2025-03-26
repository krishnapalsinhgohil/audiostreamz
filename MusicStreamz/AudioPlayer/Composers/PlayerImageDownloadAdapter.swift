//
//  PlayerImageDownloadAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 11/07/23.
//

import Foundation
  
final class PlayerImageDownloadAdapter: PlayerImageLoadingDelegate {
  
  var presenter: MusicFeedImagePresenter?
  private var task: URLSessionDataTask?
  private let imageLoader: ImageLoader
  
  init(imageLoader: ImageLoader) {
    self.imageLoader = imageLoader
    
  }

  func didCancelRequest() {
    task?.cancel()
  }

  func didRequestImage(for url: String) {
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


