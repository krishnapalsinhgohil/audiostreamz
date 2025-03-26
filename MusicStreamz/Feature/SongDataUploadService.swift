//
//  SongDataUploadService.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 22/06/23.
//

import Foundation

protocol SongsDataService {
  func setSongsData(metaDatas: [AudioMetadata], completion: @escaping () -> Void)
}
