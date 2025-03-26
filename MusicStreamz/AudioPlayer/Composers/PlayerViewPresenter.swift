//
//  PlayerViewPresenter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 10/07/23.
//

import Foundation

struct PlayerViewModel {
  let song: Song
  let playerState: TrackPlayer.AudioState
  let totalDuraton: Double
  let currentDuration: Double
}

protocol PlayerView {
  func display(_ viewModel: PlayerViewModel)
}

final class PlayerViewPresenter {
  
  let resourceView: PlayerView
  let errorView: MusicAudioErrorView
  let loadingView: MusicAudioLoadingView
  
  init(resourceView: PlayerView,
       errorView: MusicAudioErrorView,
       loadingView: MusicAudioLoadingView) {
    self.resourceView = resourceView
    self.errorView = errorView
    self.loadingView = loadingView
    
  }
  
  func defaultState() {}
  
  func didStartedDownloading(song: Song) {
    resourceView.display(.init(song: song, playerState: .downloading, totalDuraton: 0.0, currentDuration: 0.0))

  }
  
  func didPausePlaying(song: Song, currentDuration: Double, totalDuration: Double) {
    resourceView.display(.init(song: song, playerState: .paused, totalDuraton: totalDuration, currentDuration: currentDuration))

  }
  
  func didStartedPlaying(song: Song, currentDuration: Double, totalDuration: Double) {
    resourceView.display(.init(song: song, playerState: .playing, totalDuraton: totalDuration, currentDuration: currentDuration))
  }
  
  func didUpdateDuration(song: Song, state: TrackPlayer.AudioState, duration: Double, totalDuration: Double) {
    resourceView.display(.init(song: song, playerState: state, totalDuraton: totalDuration, currentDuration: duration))
  }
  
}
