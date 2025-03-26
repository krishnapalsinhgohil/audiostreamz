//
//  PlayerPresentationAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 10/07/23.
//

import Foundation

final class PlayerPresentationAdapter: PlayerDelegate {
  
  var presenter: PlayerViewPresenter?
  var imageDelegate: PlayerImageLoadingDelegate?
  private let player: TrackPlayer
  private let queueManager: QueueManager

  init(player: TrackPlayer,
       queueManager: QueueManager) {
    self.player = player
    self.queueManager = queueManager
  }

  func didUpdateDuration(_ object: Any?) {
    guard let object = object as? [String: Any],
          let duration = object["duration"] as? PlayerDuration,
          let song = queueManager.getCurrentSong()
    else { return }

    presenter?.didUpdateDuration(song: song, state: player.getState(), duration: duration.currentTime, totalDuration: duration.totalTime)
    
  }
  
  func getState() {
    
    guard let song = queueManager.getCurrentSong() else {
      presenter?.defaultState()
      return
    }
    
    switch player.getState() {
    case .default:
      presenter?.defaultState()
      
    case .downloading:
      imageDelegate?.didRequestImage(for: song.albumURL)
      presenter?.didStartedDownloading(song: song)
      
    case .paused:
      presenter?.didPausePlaying(song: song, currentDuration: player.currentDuration, totalDuration: player.playerDuration)
      
    case .playing:
      presenter?.didStartedPlaying(song: song, currentDuration: player.currentDuration, totalDuration: player.playerDuration)
    }
    
  }
  
  func play() {
    guard let song = queueManager.getCurrentSong() else {return}

    if player.getState() == .paused {
      player.resume()
    }
    presenter?.didStartedPlaying(song: song, currentDuration: player.currentDuration, totalDuration: player.playerDuration)
  }
  
  func pause() {
    guard let song = queueManager.getCurrentSong() else {return}
    
    presenter?.didPausePlaying(song: song, currentDuration: player.currentDuration, totalDuration: player.playerDuration)
    player.pause()
  }
  
  func fastForward() {
    
  }
  
  func fastBackward() {
    
  }
  
  func goToNext() {
    
  }
  
  func goToPrevious() {
    
  }
  
  func seekTo() {
    
  }
  
}
