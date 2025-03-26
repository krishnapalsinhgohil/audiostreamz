//
//  MiniPlayerViewController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 06/07/23.
//

import Foundation

class MiniPlayerViewController {
  var miniPlayerView: MiniPlayerView?
  let trackPlayer: TrackPlayer?
  let queueManager: QueueManager?

  let openPlayer: () -> Void
  
  private var observers: [AnyObject] = []
  
  init(trackPlayer: TrackPlayer,
       queueManager: QueueManager,
       openPlayer: @escaping () -> Void) {
    self.openPlayer = openPlayer
    self.trackPlayer = trackPlayer
    self.queueManager = queueManager
    
    setupMiniPlayer()
    setupObservers()
  }
  
  private func setupObservers() {
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackPlayingNotification,
        object: nil,
        queue: nil
      ) { [weak self] _ in
        self?.handlePlayerState()
      }
    )
    
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackNotPlayingNotification,
        object: nil,
        queue: nil
      ) { [weak self] _ in
        self?.handlePlayerState()
      }
    )
    
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackPausedNotification,
        object: nil,
        queue: nil
      ) { [weak self] _ in
        self?.handlePlayerState()

      }
    )
    
    observers.append(
      NotificationCenter.default.addObserver(
        forName: .TrackDownloadingNotification,
        object: nil,
        queue: nil
      ) { [weak self] _ in
        self?.handlePlayerState()
      }
    )
  
  }
  
  
  private func setupMiniPlayer() {
    miniPlayerView = MiniPlayerView(trackPlayer: trackPlayer)
    miniPlayerView?.isHidden = true
    miniPlayerView?.openPlayer = openPlayer
  }
  
  private func handlePlayerState() {
    guard let song = queueManager?.getCurrentSong(), let trackPlayer, trackPlayer.getState() != .default else {
      miniPlayerView?.isHidden = true
      return
    }
    
    miniPlayerView?.isHidden = false
    miniPlayerView?.set(title: song.name, artist: song.artist)
    
    switch trackPlayer.getState() {
    case .paused:
      miniPlayerView?.setPauseState()
      
    case .playing:
      miniPlayerView?.setPlayState()
      
    default:
      break
      
    }
    
  }
  
  
  deinit {
    observers.forEach({
      NotificationCenter.default.removeObserver($0)
    })
  }

  
}
