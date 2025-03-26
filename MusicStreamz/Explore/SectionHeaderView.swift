//
//  SectionHeaderView.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
  
  static let identifier = "SectionHeaderView"
  
  private(set) lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .medium)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  func setupViews() {
    addSubview(titleLabel)
    titleLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 16, leftConstant: 0, rightConstant: 16)
    
  }
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()

  }
  
}
