//
//  UploadViewPresentationAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 05/07/23.
//

import Foundation

final class UploadViewPresentationAdapter: AudioUploadDelegate {
  
  var presenter: UploadViewPresenter?
  private let service: AudioMetadataService
  
  init(service: AudioMetadataService) {
    self.service = service
  }

  func uploadFiles(from urls: [URL]) {
    service.fetchMetadata(from: urls) { songs in
      
    }
  }
  
}
