//
//  PlayerControlView.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 07/07/23.
//

import UIKit

class PlayerControlView: BaseView {
  private lazy var playButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(.init(systemName: "play.circle.fill"), for: .normal)
    button.tintColor = .themeBackground
    button.isHidden = true
    button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
    return button
  }()

  private lazy var pauseButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(.init(systemName: "pause.circle.fill"), for: .normal)
    button.tintColor = .themeBackground
    button.addTarget(self, action: #selector(pauseTapped), for: .touchUpInside)
    return button
  }()
  
  private lazy var nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(.init(systemName: "forward"), for: .normal)
    button.tintColor = .themeBackground
    return button
  }()
  
  private lazy var prevButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(.init(systemName: "backward"), for: .normal)
    button.tintColor = .themeBackground
    return button
  }()
  
  private let mainControlSize: CGFloat = 60

  var didTapPause: (() -> Void)?
  
  var didTapPlay: (() -> Void)?

  
  override func setupViews() {
    super.setupViews()
        
    let viewStack = hstack([prevButton, playButton, pauseButton, nextButton], spacing: 16, alignment: .center, distribution: .fill)

    [playButton, pauseButton].forEach({
      $0.anchorTo(size: .init(width: mainControlSize, height: mainControlSize))
      $0.setPreferredSymbolConfiguration(.init(pointSize: mainControlSize), forImageIn: .normal)
    })
    
    [nextButton, prevButton].forEach({
      $0.anchorTo(size: .init(width: mainControlSize/2, height: mainControlSize/2))
      $0.setPreferredSymbolConfiguration(.init(pointSize: mainControlSize/2), forImageIn: .normal)

    })

    addSubview(viewStack)
    viewStack.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    
  }
  
  private func playingState() {
    playButton.isHidden = true
    pauseButton.isHidden = false

  }
  
  
  @objc private func playTapped() {
    didTapPlay?()
  }
  

  @objc private func pauseTapped() {
    didTapPause?()
  }
  
  func set(audioState: TrackPlayer.AudioState) {
    switch audioState {
    case .playing:
      playingState()
      
    case .paused:
      playButton.isHidden = false
      pauseButton.isHidden = true
      
    case .downloading:
      playingState()
      
    case .default:
      playingState()
    }
    
  }
  
}
