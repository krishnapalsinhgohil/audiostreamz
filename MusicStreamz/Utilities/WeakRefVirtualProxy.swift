//
//  WeakRefVirtualProxy.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 10/07/23.
//

import Foundation

class WeakRefVirtualProxy<T: AnyObject> {
  weak var object: T?
  
  init(_ object: T) {
    self.object = object
  }
  
}

extension WeakRefVirtualProxy: PlayerView where T: PlayerView {
  func display(_ viewModel: PlayerViewModel) {
    object?.display(viewModel)
    
  }
  
}

extension WeakRefVirtualProxy: MusicAudioErrorView where T: MusicAudioErrorView {
  func display(_ viewModel: MusicAudioErrorViewModel) {
    object?.display(viewModel)

  }
}

extension WeakRefVirtualProxy: MusicAudioLoadingView  where T: MusicAudioLoadingView {
  func display(_ viewModel: MusicAudioLoadingViewModel) {
    object?.display(viewModel)

  }
}


extension WeakRefVirtualProxy: MusicFeedView where T: MusicFeedView {
  func display(_ viewModel: MusicImageViewModel) {
    object?.display(viewModel)
  }
}


extension WeakRefVirtualProxy: ResourceLoadingView where T: ResourceLoadingView {
  func display(viewModel: Bool) {
    object?.display(viewModel: viewModel)
  }
}

extension WeakRefVirtualProxy: ResourceErrorView where T: ResourceErrorView {
  func display(viewModel: Error?) {
    object?.display(viewModel: viewModel)
  }
}

extension WeakRefVirtualProxy: MusicAudioView where T: MusicAudioView {
  func display(_ viewModel: MusicAudioViewModel) {
    object?.display(viewModel)
  }
}

