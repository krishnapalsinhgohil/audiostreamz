//
//  ImageLoader.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import Foundation

protocol ImageLoader {
  func loadImage(from url: String,
                 completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask?
}

