//
//  UploadViewPresenter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 05/07/23.
//

import Foundation

struct UploadViewModel {
  var songs: [Song]
}

protocol UploadView {
  func display(_ viewModel: UploadViewModel)
}

final class UploadViewPresenter {
  
  var view: UploadView
  var loadingView: ResourceLoadingView
  var errorView: ResourceErrorView
  
  init(view: UploadView, loadingView: ResourceLoadingView, errorView: ResourceErrorView) {
    self.view = view
    self.loadingView = loadingView
    self.errorView = errorView
  }
  
  func didStartLoading() {
    loadingView.display(viewModel: true)
    errorView.display(viewModel: nil)
  }
  
  func didFinishLoading(with data: [Song]) {
    loadingView.display(viewModel: false)
    view.display(UploadViewModel(songs: data))
  }
  
  func didFinishLoading(with error: Error) {
    loadingView.display(viewModel: false)
    errorView.display(viewModel: error)
  }
  
}
