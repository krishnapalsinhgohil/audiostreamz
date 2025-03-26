//
//  PlayerViewController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 07/07/23.
//

import UIKit

protocol PlayerImageLoadingDelegate {
  func didRequestImage(for url: String)
  func didCancelRequest()
}

protocol PlayerDelegate {
  func getState()
  func didUpdateDuration(_ object: Any?)
  func play()
  func pause()
  func fastForward()
  func fastBackward()
  func goToNext()
  func goToPrevious()
  func seekTo()
}

class PlayerViewController: BaseViewController {
  
  var playerDelegate: PlayerDelegate?
  
  private lazy var albumArtImageView: ImageView = {
    let imageView = ImageView()
    imageView.layer.masksToBounds = true
    return imageView
  }()

  private lazy var songLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  private lazy var songSliderContainer: SongSliderContainerView = {
    let container = SongSliderContainerView()
    return container
  }()
  
  private lazy var playerControlView: PlayerControlView = {
    let controlView = PlayerControlView()
    controlView.didTapPause = playerDelegate?.pause
    controlView.didTapPlay = playerDelegate?.play
    return controlView
  }()
  
  private lazy var queueButton: UIButton = {
    let button = UIButton()
    button.setImage(.init(systemName: "list.bullet"), for: .normal)
    button.tintColor = .black
    button.setPreferredSymbolConfiguration(.init(scale: .large), forImageIn: .normal)
    return button
  }()
  
  var observers: [AnyObject] = []
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupObservers()
    playerDelegate?.getState()

  }
  
  override func setupViews() {
    super.setupViews()
    view.backgroundColor = .white

    navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
    
    navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    
    setupPlayerControllerView()
    
  }
  
  private func setupObservers() {
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackPlayingNotification,
        object: nil,
        queue: nil
      ) { [weak self] _ in
        self?.playerDelegate?.getState()
      }
    )
    
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackNotPlayingNotification,
        object: nil,
        queue: nil
      ) { [weak self] _ in
        self?.playerDelegate?.getState()
      }
    )
    
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackPausedNotification,
        object: nil,
        queue: nil
      ) { [weak self] _ in
        self?.playerDelegate?.getState()
        
      }
    )
    
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackDownloadingNotification,
        object: nil,
        queue: nil
      ) { [weak self] _ in
        self?.playerDelegate?.getState()
      }
    )
    
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackDurationNotification,
        object: nil,
        queue: nil
      ) { [weak self] notification in
        self?.playerDelegate?.didUpdateDuration(notification.object)
      }
    )

  }
  
  private func setupPlayerControllerView() {
    let playerContainerView = UIView()
    view.addSubview(playerContainerView)
    playerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    playerContainerView.anchorCenterXToSuperview()
    playerContainerView.anchorCenterYToSuperview()
    
    let albumArtContainerImageView = UIView()
    
    
    playerContainerView.addSubview(albumArtContainerImageView)
    albumArtContainerImageView.backgroundColor = .themeBackground
    albumArtContainerImageView.layer.cornerRadius = 8
    albumArtContainerImageView.clipsToBounds = true

    albumArtContainerImageView.anchorCenterXToSuperview()
    albumArtContainerImageView.anchor(playerContainerView.topAnchor, topConstant: 16)
    albumArtContainerImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    albumArtContainerImageView.heightAnchor.constraint(equalTo: albumArtContainerImageView.widthAnchor, multiplier: 1).isActive = true
    albumArtContainerImageView.addSubview(albumArtImageView)
    albumArtImageView.fillSuperview()

    
    playerContainerView.addSubview(songLabel)
    songLabel.anchor(albumArtContainerImageView.bottomAnchor, topConstant: 24)
    songLabel.anchorCenterXToSuperview()
    songLabel.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: 16).isActive = true
    songLabel.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -16).isActive = true
    
    playerContainerView.addSubview(songSliderContainer)
    songSliderContainer.anchor(songLabel.bottomAnchor,
                               left: albumArtContainerImageView.leftAnchor,
                               right: albumArtContainerImageView.rightAnchor,
                               topConstant: 16)
    
    playerContainerView.addSubview(playerControlView)
    playerControlView.anchor(songSliderContainer.bottomAnchor, bottom: playerContainerView.bottomAnchor,
                             topConstant: 16)
    playerControlView.anchorCenterXToSuperview()
  }
  
  @objc private func closeTapped() {
    dismiss(animated: true)
  }
  
  @objc private func shareTapped() {
    print(">> Share tapped")
  }
  
  deinit {
    observers.forEach({
      NotificationCenter.default.removeObserver($0)
    })
  }
  
}

extension PlayerViewController: PlayerView {
  func display(_ viewModel: PlayerViewModel) {
    
    songLabel.attributedText = .songDetails(from: viewModel.song.name, artist: viewModel.song.artist, titleFontSize: 20, subTitleFontSize: 14)
    
    playerControlView.set(audioState: viewModel.playerState)
    songSliderContainer.set(duration: viewModel.currentDuration, totalDuration: viewModel.totalDuraton)
  }
  
}

extension PlayerViewController: MusicAudioErrorView {
  func display(_ viewModel: MusicAudioErrorViewModel) {
    
  }
}

extension PlayerViewController: MusicAudioLoadingView {
  func display(_ viewModel: MusicAudioLoadingViewModel) {
    
  }
}

extension PlayerViewController: MusicFeedView {
  func display(_ viewModel: MusicImageViewModel) {
    albumArtImageView.image = UIImage(data: viewModel.image)
  }
}

extension PlayerViewController: ResourceLoadingView {
  func display(viewModel: Bool) {
    if viewModel {
      albumArtImageView.showLoading()
      
    }else {
      albumArtImageView.hideLoading()
      
    }
    
  }
}

extension PlayerViewController: ResourceErrorView {
  func display(viewModel: Error?) {
    albumArtImageView.image = UIImage()
  }
}



