//
//  NSMutableString+SongTitle.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 05/07/23.
//

import Foundation
import UIKit

extension NSAttributedString {
  
  static func songDetails(from name: String,
                          artist: String,
                          foregroundTitleColor: UIColor = .black,
                          foregroundSubtitleColor: UIColor = .lightGray,
                          titleFontSize: CGFloat = 14,
                          subTitleFontSize: CGFloat = 13) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(
      string: name,
      attributes: [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: titleFontSize, weight: .semibold),
        NSAttributedString.Key.foregroundColor : foregroundTitleColor
      ]
    )
    
    attributedString.append(
      NSAttributedString(
        string: "\n\n",
        attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 2)]
      )
    )
    
    attributedString.append(
      NSAttributedString(
        string: artist, attributes: [
          NSAttributedString.Key.font : UIFont.systemFont(ofSize: subTitleFontSize),
          NSAttributedString.Key.foregroundColor : foregroundSubtitleColor
        ]
      )
    )

    return attributedString
  }
  
}
