//
//  TrackInfoListCell.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import UIKit

class TrackInfoListCell: BaseTableViewCell {
  
  private(set) lazy var posterImageView: ImageView = {
    let imageView = ImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 4
    return imageView
  }()
  
  private(set) lazy var trackLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()
  
  private(set) lazy var loadingIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.tintColor = .themeBackground
    activityIndicator.hidesWhenStopped = true
    activityIndicator.isHidden = true
    return activityIndicator
  }()

  private(set) lazy var trackPlayButton: UIButton = {
    let button = UIButton()
    button.setImage(.init(systemName: "play.circle"), for: .normal)
    button.tintColor = .themeBackground
    button.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
    button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
    return button
  }()

  private(set) lazy var trackPauseButton: UIButton = {
    let button = UIButton()
    button.setImage(.init(systemName: "pause.circle"), for: .normal)
    button.tintColor = .themeBackground
    button.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
    button.addTarget(self, action: #selector(pauseTapped), for: .touchUpInside)
    button.isHidden = true
    return button
  }()
  
  private lazy var equaliserView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage.gifImageWithName(name: "waveform")
    imageView.backgroundColor = .themeBackground.withAlphaComponent(0.5)
    return imageView
  }()
  
  static let identifier = "TrackInfoListCell"

  var onReuse: (() -> Void)?
  var onTapPlay: (()-> Void)?
  var onTapPause: (()-> Void)?

  override func prepareForReuse() {
    super.prepareForReuse()
    onReuse?()
  }
  
  override func setupViews() {
    super.setupViews()
    
    let trackControlViews = [trackPlayButton, trackPauseButton]
    trackControlViews.forEach( { $0.anchorTo(size: .init(width: 26, height: 44)) } )
    
    let stackView = hstack(trackControlViews,
                           spacing: 6,
                           alignment: .center,
                           distribution: .fillEqually)
    
    contentView.addSubviews(posterImageView, trackLabel, stackView, loadingIndicator)

    loadingIndicator.anchorTo(size: .init(width: 0, height: 44))
    
    stackView.anchorTo(size: .init(width: 0, height: 44))
    
    loadingIndicator.anchorCenterYToSuperview()
    loadingIndicator.anchor(right: contentView.rightAnchor, rightConstant: 16)
    
    stackView.anchorCenterYToSuperview()
    stackView.anchor(right: contentView.rightAnchor, rightConstant: 16)
    
    posterImageView.anchorTo(size: .init(width: 44, height: 44))
    posterImageView.anchorCenterYToSuperview()
    posterImageView.anchor(left: contentView.leftAnchor, leftConstant: 8)
    trackLabel.anchor(contentView.topAnchor,
                      left: posterImageView.rightAnchor,
                      bottom: contentView.bottomAnchor,
                      right: stackView.leftAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8)
  }
   
  @objc private func playTapped() {
    onTapPlay?()
  }
  
  @objc private func pauseTapped() {
    onTapPause?()
  }
  
  func playingState() {
    contentView.addSubview(equaliserView)
    equaliserView.translatesAutoresizingMaskIntoConstraints = false
    equaliserView.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor).isActive = true
    equaliserView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor).isActive = true
    equaliserView.anchorTo(size: .init(width: 44, height: 44))
    
    trackPlayButton.isHidden = true
    trackPauseButton.isHidden = false
    trackLabel.textColor = .themeBackground
  }
  
  func defaultState() {
    equaliserView.removeFromSuperview()
    trackLabel.textColor = .black
    trackPlayButton.isHidden = false
    trackPauseButton.isHidden = true
  }
  
  func downloadingState() {
    equaliserView.removeFromSuperview() 
    trackLabel.textColor = .themeBackground
    loadingIndicator.startAnimating()
    loadingIndicator.isHidden = false
    trackPlayButton.isHidden = true
    trackPauseButton.isHidden = true
  }
  
  func pausedState() {
    equaliserView.removeFromSuperview()
    trackLabel.textColor = .themeBackground
    trackPlayButton.isHidden = false
    trackPauseButton.isHidden = true
  }
  
}

