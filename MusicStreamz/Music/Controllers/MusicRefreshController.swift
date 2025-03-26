//
//  MusicRefreshController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 28/06/23.
//

import Foundation
import UIKit

class MusicRefereshController: NSObject {
  var delegate: MusicFeedLoadingDelegate
  
  lazy var view : UIRefreshControl = {
    let control = UIRefreshControl()
    control.tintColor = .themeBackground
    control.addTarget(self, action: #selector(refreshTapped), for: .valueChanged)
    return control
  }()
  
  init(delegate: MusicFeedLoadingDelegate) {
    self.delegate = delegate
  }
  
  func refresh() {
    refreshTapped()
  }
  
  @objc private func refreshTapped() {
    delegate.didRequestMusicItems()
  }
  
}
