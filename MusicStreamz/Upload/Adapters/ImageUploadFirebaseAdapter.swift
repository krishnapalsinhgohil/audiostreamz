//
//  ImageUploadFirebaseAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 22/06/23.
//

import Foundation
import FirebaseStorage

final class AudioMetadataAdapter: TrackImageUploadService {
  func uploadImage(data: Data, completion: @escaping (Result<String, Error>) -> Void) {
    let reference = Storage.storage().reference().child("song_artwork/\(UUID().uuidString).jpg")
    reference.putData(data) { result in
      switch result {
      case .success:
        reference.downloadURL { downloadURL, error in
          guard let downloadURL else {return}
          completion(.success(downloadURL.absoluteString))
        }
        
      case .failure(let failure):
        completion(.failure(failure))
      }
    }
  }

  func uploadImages(from data: [PartialMetaDataWithAudioURL],
                    completion: @escaping (Result<[AudioMetadata], Error>) -> Void) {
    
    let dispatchGroup = DispatchGroup()
    
    var audioMetadata = [AudioMetadata]()
    
    for item in data {
      dispatchGroup.enter()
      uploadImage(data: item.imageData) { result in
        switch result {
        case .success(let imageURL):
          audioMetadata.append(AudioMetadata(data: item, albumURL: imageURL))
          dispatchGroup.leave()
     
        case .failure:
          dispatchGroup.leave()
          return
          
        }
      }
      
    }
    
    dispatchGroup.notify(queue: .main) {
      completion(.success(audioMetadata))
    }
    
  }
  
}

