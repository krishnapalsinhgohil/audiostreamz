//
//  QueueManager.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 07/07/23.
//

class QueueManager {
  
  private var queue: [Song] = []
  private var currentSong: Song?
  
  func add(song: Song) {
    if !queue.contains(song) {
      queue.append(song)
    }
    
    currentSong = song
    
  }
  
  func clear() {
    queue.removeAll()
  }
  
  func getCurrentSong() -> Song? {
    return currentSong
  }
  
}
