//
//  BaseTableViewCell.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  func setupViews()  {}
  
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
}
