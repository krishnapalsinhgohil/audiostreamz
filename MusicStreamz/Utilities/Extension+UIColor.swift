//
//  Extension+UIColor.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

extension UIColor {
  
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
  static let themeBackground = rgb(red: 213, green: 118, blue: 62)
  static let miniPlayerBackground = rgb(red: 220, green: 184, blue: 159)
  
}
