//
//  Extension+UIViewController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

extension UIViewController {
  
  func withTabBarImage(image: String) -> UIViewController {
    let image = UIImage(systemName: image)?.withRenderingMode(.alwaysTemplate)
    tabBarItem = .init(title: nil, image: image, selectedImage: image)
    return self
  }
  
  
}
