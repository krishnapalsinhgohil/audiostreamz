//
//  MiniPlayerView.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 05/07/23.
//

import UIKit

class MiniPlayerView: BaseView {
  private lazy var songLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.isUserInteractionEnabled = true
    label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedLabel)))
    return label
  }()
  
  private lazy var pauseButton: UIButton = {
    let button = UIButton()
    button.setImage(.init(systemName: "pause.fill"), for: .normal)
    button.tintColor = .themeBackground
    button.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
    button.addTarget(self, action: #selector(pauseTapped), for: .touchUpInside)
    button.isHidden = true
    return button
  }()
  
  private lazy var playButton: UIButton = {
    let button = UIButton()
    button.setImage(.init(systemName: "play.fill"), for: .normal)
    button.tintColor = .themeBackground
    button.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
    button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
    button.isHidden = true
    return button
  }()

  var openPlayer: (() -> Void)?
  
  private var trackPlayer: TrackPlayer?
  
  convenience init(trackPlayer: TrackPlayer?) {
    self.init()
    self.trackPlayer = trackPlayer
  }
  
  @objc private func tappedLabel() {
    openPlayer?()
  }
  
  override func setupViews() {
    backgroundColor = .miniPlayerBackground
    addSubviews(songLabel, pauseButton, playButton)
    
    playButton.anchor(right: rightAnchor, rightConstant: 16)
    playButton.anchorTo(size: .init(width: 20, height: 20))
    playButton.anchorCenterYToSuperview()

    pauseButton.anchor(right: rightAnchor, rightConstant: 16)
    pauseButton.anchorTo(size: .init(width: 20, height: 20))
    pauseButton.anchorCenterYToSuperview()
    
    songLabel.anchor(topAnchor,
                     left: leftAnchor,
                     bottom: bottomAnchor,
                     right: pauseButton.leftAnchor,
                     topConstant: 16,
                     leftConstant: 8, bottomConstant: 16, rightConstant: 16)
        
  }
  
  
  func set(title: String, artist: String) {
    songLabel.attributedText = .songDetails(from: title, artist: artist,
                                            foregroundTitleColor: .white,
                                            foregroundSubtitleColor: .white)

  }
  
  func setPauseState() {
    playButton.isHidden = false
    pauseButton.isHidden = true

  }
  
  func setPlayState() {
    playButton.isHidden = true
    pauseButton.isHidden = false

  }
  
  @objc private func pauseTapped() {
    trackPlayer?.pause()
    setPauseState()

  }
  
  @objc private func playTapped() {
    trackPlayer?.resume()
    setPlayState()

  }
  
  
  
}
