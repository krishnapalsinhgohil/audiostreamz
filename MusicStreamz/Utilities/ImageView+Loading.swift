//
//  ImageView+Loading.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 11/07/23.
//

import Foundation
import UIKit

class ImageView: UIImageView {
  
  private lazy var loadingView: UIActivityIndicatorView = {
    return UIActivityIndicatorView(style: .medium)
  }()
  
  func showLoading() {
    addSubview(loadingView)
    loadingView.startAnimating()
    loadingView.fillSuperview()
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 0.2
  }
  
  func hideLoading() {
    loadingView.removeFromSuperview()
    layer.borderColor = UIColor.clear.cgColor
    layer.borderWidth = 0.0
  }
  
}
