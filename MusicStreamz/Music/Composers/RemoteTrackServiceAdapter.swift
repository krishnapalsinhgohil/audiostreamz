//
//  RemoteTrackServiceAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import Foundation
import FirebaseDatabase

class SongMapper {
  struct Root: Decodable {
    let id: String
  }
  
  struct Track: Decodable {
    let name: String
    let artist: String
    let albumURL: String
    let downloadURL: String
  }

  static func map(data: Any) throws -> [Song] {
    guard let dictionary = data as? [String: Any] else {
      throw NSError(domain: "Expected a dictionary", code: 0)
    }
    
    return try dictionary.keys.map { key in
      guard let dict = dictionary[key] as? [String: Any] else { throw NSError(domain: "Expected a dictionary", code: 0) }
      let data = try JSONSerialization.data(withJSONObject: dict)
      let result = try JSONDecoder().decode(Track.self, from: data)
      return Song(id: key, name: result.name, artist: result.artist, downloadURL: result.downloadURL, albumURL: result.albumURL)
    }
    
  }
  
}

class RemoteSongLoader: SongLoader {
  
  func getSongs(completion: @escaping (Result<[Song], Error>) -> Void) {
    Database.database().reference().child("songs").getData { error, snapshot in
      
      if let error {
        completion(.failure(error))
        return
      }

      guard let value = snapshot?.value as? Any else {
        completion(.failure(NSError(domain: "Failed to retrive snapshot from -> songs/", code: 0)))
        return
      }
      
      do {
        completion(.success(try SongMapper.map(data: value)))

      }catch let error {
        completion(.failure(error))

      }

    }
    
  }
  
}
