//
//  ResourceView.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 11/07/23.
//

import Foundation

protocol ResourceViewProtocol {
  associatedtype ResourceViewModel
  func display(_ viewModel: ResourceViewModel)
}

// ===========

struct ResourceErrorViewModel {
  var error: Error?
  
  static func withError(error: Error) -> ResourceErrorViewModel {
    return ResourceErrorViewModel(error: error)
  }
  
  static func noError() -> ResourceErrorViewModel {
    return ResourceErrorViewModel()
  }
}

protocol ResourceErrorViewProtocol {
  func display(_ viewModel: ResourceErrorViewModel)
}

// ===========

struct ResourceLoadingViewModel {
  var isLoading: Bool
}

protocol ResourceLoadingViewProtocol {
  func display(_ viewModel: ResourceLoadingViewModel)
}

