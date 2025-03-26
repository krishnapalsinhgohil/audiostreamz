//
//  MusicListPresenter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 28/06/23.
//

import Foundation

protocol MusicView {
  func display(viewModel: [Song])
}

protocol ResourceErrorView {
  func display(viewModel: Error?)
}

protocol ResourceLoadingView {
  func display(viewModel: Bool)
}

final class MusicListPresenter {
  
  private let view: MusicView
  private let errorView: ResourceErrorView
  private let loadingView: ResourceLoadingView
  
  init(view: MusicView, errorView: ResourceErrorView, loadingView: ResourceLoadingView) {
    self.view = view
    self.errorView = errorView
    self.loadingView = loadingView
  }
  
  func didStartLoading() {
    errorView.display(viewModel: nil)
    loadingView.display(viewModel: true)
  }
  
  func didFinishLoading(with error: Error) {
    errorView.display(viewModel: error)
    loadingView.display(viewModel: false)
  }
  
  func didFinishLoading(with songs: [Song]) {
    view.display(viewModel: songs)
    loadingView.display(viewModel: false)
  }
  
}
