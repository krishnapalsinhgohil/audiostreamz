//
//  Extension+String.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

extension String {
  func toImage(withRenderingMode isTemplated: Bool = false) -> UIImage {
      if let imageToReturn = UIImage(named: self) {
          return imageToReturn.withRenderingMode(isTemplated ? .alwaysTemplate : .alwaysOriginal)
      } else {
          return UIImage()
      }
  }

}
