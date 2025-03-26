//
//  TrackService.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import Foundation

protocol SongLoader {
  func getSongs(completion: @escaping (Result<[Song], Error>) -> Void)
}

