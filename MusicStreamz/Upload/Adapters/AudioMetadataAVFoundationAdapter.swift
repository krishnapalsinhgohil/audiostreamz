//
//  AudioMetadataAVFoundationAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 22/06/23.
//

import Foundation
import AVFoundation

struct PartialMetaData {
  let url: URL
  let title: String
  let artist: String
  let imageData: Data
}

struct PartialMetaDataWithAudioURL {
  let url: URL
  let title: String
  let artist: String
  let imageData: Data
  let downloadURL: String
  
  init(data: PartialMetaData, downloadURL: String) {
    self.downloadURL = downloadURL
    self.url = data.url
    self.title = data.title
    self.artist = data.artist
    self.imageData = data.imageData
  }
}

struct AudioMetadata {
  let title: String
  let artist: String
  let downloadURL: String
  let albumURL: String
  
  init(data: PartialMetaDataWithAudioURL, albumURL: String) {
    self.albumURL = albumURL
    self.title = data.title
    self.artist = data.artist
    self.downloadURL = data.downloadURL
  }
  
}

protocol AudioMetadataService {
  func fetchMetadata(from urls: [URL],
                     completion: @escaping (([PartialMetaData], UploadFailedModel)) -> Void)
}

protocol AudioUploadService {
  func uploadAudio(for metaDatas: [PartialMetaData],
                   completion: @escaping (Result<([PartialMetaDataWithAudioURL], UploadFailedModel), Error>) -> Void)
}

protocol TrackImageUploadService {
  func uploadImages(from data: [PartialMetaDataWithAudioURL],
                    completion: @escaping (Result<[AudioMetadata], Error>) -> Void)
}

final class MetadataFetcher {
  
  static func getMetaData(from url: URL) throws -> PartialMetaData {
    let asset = AVPlayerItem(url: url)
    let metadataList = asset.asset.metadata
    var title: String = ""
    var artist: String = ""
    var imageData: Data = Data()
    
    for item in metadataList {
      guard let key = item.commonKey?.rawValue,
            let value = item.value else {
        continue;
      }
      
      switch key {
      case "title" : title = value as? String ?? ""
      case "artist": artist = value as? String ?? ""
      case "artwork" where value is Data : imageData = value as! Data
      default:
        continue
      }
      
    }
    
    if title == "" && artist == "" && imageData == Data() {
      throw NSError(domain: "Found nil values for url, \(url)", code: 0)
    }
    
    return PartialMetaData(url: url, title: title, artist: artist, imageData: imageData)
    
  }
  
}

final class URLToPartialMetaDataAdapter: AudioMetadataService {
  
  func fetchMetadata(from urls: [URL],
                     completion: @escaping (([PartialMetaData], UploadFailedModel)) -> Void) {
    
    var failedURLs = [URL]()
    var partialMetaData = [PartialMetaData]()
    
    for url in urls {
      do {
        partialMetaData.append(try MetadataFetcher.getMetaData(from: url))
        
      } catch {
        failedURLs.append(url)
        
      }
      
    }
    
    completion((partialMetaData, UploadFailedModel(urls: failedURLs)))
    
  }
  
}

