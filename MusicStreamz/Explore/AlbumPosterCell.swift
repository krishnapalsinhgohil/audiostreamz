//
//  AlbumPosterCell.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

class AlbumPosterCell: UICollectionViewCell {
  
  private(set) lazy var posterImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.backgroundColor = .yellow
    return imageView
  }()
  
  private(set) lazy var posterLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  func setupViews() {
    contentView.addSubviews(posterLabel, posterImage)
    
    posterLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    posterImage.anchor(topAnchor, left: leftAnchor, bottom: posterLabel.topAnchor, right: rightAnchor, bottomConstant: 8)

  }
    
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  
}
