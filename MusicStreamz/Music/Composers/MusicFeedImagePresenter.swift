//
//  MusicFeedImagePresenter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 28/06/23.
//

import Foundation

struct MusicImageViewModel {
  let image: Data
}

protocol MusicFeedView {
  func display(_ viewModel: MusicImageViewModel)
}

final class MusicFeedImagePresenter {
  var view: MusicFeedView
  var loadingView: ResourceLoadingView
  var errorView: ResourceErrorView
  
  init(view: MusicFeedView, loadingView: ResourceLoadingView, errorView: ResourceErrorView) {
    self.view = view
    self.loadingView = loadingView
    self.errorView = errorView
  }
  
  func didStartLoading() {
    errorView.display(viewModel: nil)
    loadingView.display(viewModel: true)
  }
  
  func didFinishLoading(with data: Data) {
    loadingView.display(viewModel: false)
    view.display(MusicImageViewModel(image: data))
  }
  
  func didFinishLoading(with error: Error) {
    loadingView.display(viewModel: false)
    errorView.display(viewModel: error)

  }
}
