//
//  PartialMetaDataWithAudioURLAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 22/06/23.
//

import Foundation
import FirebaseStorage

struct UploadFailedModel {
  let urls: [URL]
}

class PartialMetaDataWithAudioURLAdapter: AudioUploadService {
  func uploadAudio(for metaDatas: [PartialMetaData], completion: @escaping (Result<([PartialMetaDataWithAudioURL], UploadFailedModel), Error>) -> Void) {
    let dispatchGroup = DispatchGroup()
    
    var partialMetaDatas: [PartialMetaDataWithAudioURL] = []
    var failedURLs: [URL] = []
    
    for metaData in metaDatas {
      dispatchGroup.enter()
      uploadAudio(for: metaData.url) { result in
        switch result {
        case .success(let downloadURL):
          partialMetaDatas.append(PartialMetaDataWithAudioURL(data: metaData, downloadURL: downloadURL))
          dispatchGroup.leave()
          
        case .failure:
          failedURLs.append(metaData.url)
          dispatchGroup.leave()
        }
      }
      
    }
    
    dispatchGroup.notify(queue: .main) {
      completion(.success((partialMetaDatas, UploadFailedModel(urls: failedURLs))))
    }
    
  }
  
  func uploadAudio(for url: URL, completion: @escaping (Result<String, Error>) -> Void) {
    let reference = Storage.storage().reference().child("songs/\(UUID().uuidString)")
    reference.putFile(from: url) { result in
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
  
}
