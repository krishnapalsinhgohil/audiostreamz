//
//  AudioPlayerService.swift
//  SoundBiz
//
//  Created by Krishnapal Sinh Gohil on 30/06/23.
//

import Foundation
import AVKit

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
  var player: AVAudioPlayer = AVAudioPlayer()
  
  private var completion: (() -> Void)?
  
  func play(data: Data, completion: @escaping () -> Void) throws {
    self.completion = completion
    player.stop()
    player = try AVAudioPlayer(data: data)
    player.delegate = self
    player.prepareToPlay()
    player.play()
  }
  
  func stop() {
    player.stop()
  }
  
  func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
    if let error {
      print("==> ERROR PLAYING AUDIO \(error.localizedDescription)")
      return
    }
    
  }
 
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    completion?()
  }

}

protocol AudioPlayerService {
  func playSound(data: Data, completion: @escaping () -> Void)
}

class AudioPlayService: NSObject, AVAudioPlayerDelegate, AudioPlayerService {
  var player: AudioPlayer
  private var completion: (() -> Void)?
  
  
  init(player: AudioPlayer) {
    self.player = player
  }
    
  func playSound(data: Data, completion: @escaping () -> Void) {
    self.completion = completion
    do {
      try player.play(data: data, completion: completion)
      
    } catch let error as NSError {
     print(err)
    }
    
  }
    
  
}
