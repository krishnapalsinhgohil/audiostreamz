//
//  UploadViewComposer.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 29/06/23.
//

import Foundation

final class UploadViewComposer {
  
  private init() {}
  
  static func composedWith() -> UploadViewController {
    
    let uploadViewController = UploadViewController()
    uploadViewController.title = "My Music"
    
    let adapter = AudioUploadDelegateAdapter(audioMedataService: URLToPartialMetaDataAdapter(),
                               uploadAudioService: PartialMetaDataWithAudioURLAdapter(),
                               trackImageUploadService: AudioMetadataAdapter(),
                               songDataService: SongsRemoteAdapter())
    
    uploadViewController.delegate = adapter
        
    return uploadViewController
  }
  
}

class AudioUploadDelegateAdapter: AudioUploadDelegate {
  
  let audioMedataService: AudioMetadataService
  let uploadAudioService: AudioUploadService
  let trackImageUploadService: TrackImageUploadService
  let songDataService: SongsDataService
  
  init(audioMedataService: AudioMetadataService,
       uploadAudioService: AudioUploadService,
       trackImageUploadService: TrackImageUploadService,
       songDataService: SongsDataService) {
    
    self.audioMedataService = audioMedataService
    self.uploadAudioService = uploadAudioService
    self.trackImageUploadService = trackImageUploadService
    self.songDataService = songDataService
  }
  
  func uploadFiles(from urls: [URL]) {
    audioMedataService.fetchMetadata(from: urls) { [weak self] partialMetaDatas, failedURLModel in
      self?.uploadMetadata(metaData: partialMetaDatas)
      print(">> Failed URLs", failedURLModel.urls)
    }
    
  }
  
  func uploadMetadata(metaData: [PartialMetaData]) {
    uploadAudioService.uploadAudio(for: metaData) { [weak self] result in
      switch result {
      case let .success((partialMetaData, failedURLModel)):
        self?.uploadPartialMetaData(metadataWithURLs: partialMetaData)
        print(">> Failed URLs for uploading metaData", failedURLModel.urls)

      case .failure:
        break
      }
    }
  }
  
  
  func uploadPartialMetaData(metadataWithURLs: [PartialMetaDataWithAudioURL]) {
    trackImageUploadService.uploadImages(from: metadataWithURLs) { [weak self] result in
      switch result {
      case .success(let metaDatas):
        self?.upload(metaDatas: metaDatas)
        
      case .failure:
        break
      }
      
    }
    
  }
  
  func upload(metaDatas: [AudioMetadata]) {
    songDataService.setSongsData(metaDatas: metaDatas) {
      print("==> Upload Done")
      
    }
  }
  
  
  
}
