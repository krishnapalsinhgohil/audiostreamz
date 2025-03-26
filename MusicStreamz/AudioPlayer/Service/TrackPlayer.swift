//
//  TrackPlayer.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 30/06/23.
//

import AVKit

class TrackPlayer {
  enum AudioState { case playing, paused, downloading, `default` }
  
  private var player: AVPlayer?
  private var currentURL: URL?
  
  var playerDuration: Double {
    return player?.currentItem?.duration.seconds ?? 0.0
  }
  
  var currentDuration: Double = 0.0
  
  private var audioState: AudioState = .default {
    didSet {
      switch audioState {
      case .default:
        NotificationHandler.notifyNotPlaying()
        
      case .paused:
        NotificationHandler.notifyPause()
        
      case .playing:
        NotificationHandler.notifyPlay()
        
      case .downloading:
        NotificationHandler.notifyDownloading()
        
      }
    }
    
  }
  
  init() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(didEndPlaying),
                                           name: .AVPlayerItemDidPlayToEndTime, object: nil)

  }
  
  func getState() -> AudioState {
    return audioState
  }
  
  func play(url: URL) {
    audioState = .downloading
    
    if url == currentURL, let player {
      audioState = .playing
      player.play()
      return
    }
    
    currentURL = url
    
    player = AVPlayer(url: url)
    player?.play()
    
    
    
    player?.addPeriodicTimeObserver(forInterval: CMTime(value: CMTimeValue(1), timescale: 10), queue: DispatchQueue.main) { [weak self] (progressTime) in
      if progressTime.seconds == 0 {
        self?.audioState = .playing
      }
      
      self?.currentDuration = progressTime.seconds
      let currTime = self?.currentDuration ?? 0.0
      let totalTime = self?.playerDuration ?? 0.0
      NotificationHandler.notifyDuration(PlayerDuration(currentTime: currTime, totalTime: totalTime))

    }
    
  }
  
  @objc private func didEndPlaying() {
    stop()
  }
  
  func resume() {
    if let player {
      player.play()
    }
    
    audioState = .playing
  }
  
  func pause() {
    player?.pause()
    audioState = .paused
  }
  
  
  private func stop() {
    player = nil
    audioState = .default
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    
  }
  
}

extension AVPlayer.Status: CustomStringConvertible {
  public var description: String {
    switch self {
    case .failed:
      return "Failed"
      
    case .readyToPlay:
      return "Ready to play"
      
    case .unknown:
      return "Unknown"
      
    @unknown default:
      return "Unknown"
    }
  }
  
  
}
