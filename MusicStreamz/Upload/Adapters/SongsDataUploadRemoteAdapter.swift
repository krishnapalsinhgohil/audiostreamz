//
//  SongsRemoteAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 22/06/23.
//

import Foundation
import FirebaseDatabase

class SongsRemoteAdapter: SongsDataService {
  
  func setSongsData(metaDatas: [AudioMetadata], completion: @escaping () -> Void) {
    let dispatchGroup = DispatchGroup()
    
    for song in metaDatas {
      
      dispatchGroup.enter()
      
      setData(for: song) {
        dispatchGroup.leave()
      }
      
    }

    dispatchGroup.notify(queue: .main) {
      completion()
    }
    
  }
  
  func setData(for metaData: AudioMetadata, completion: @escaping () -> Void) {
    
    let dataToSet = [
      "name": metaData.title.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "- PagalNew", with: "").replacingOccurrences(of: "_128-(SongsPK)", with: ""),
      "artist": metaData.artist,
      "downloadURL": metaData.downloadURL,
      "albumURL": metaData.albumURL
    ]
    
    Database.database().reference().child("songs").childByAutoId().updateChildValues(dataToSet) { error, reference in
      if error == nil {
        completion()
      }
      
    }
    
  }
  
  
}
