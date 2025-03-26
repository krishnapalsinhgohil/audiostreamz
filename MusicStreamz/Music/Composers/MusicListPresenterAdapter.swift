//
//  MusicListPresenterAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 28/06/23.
//

import Foundation

final class MusicListPresenterAdapter: MusicFeedLoadingDelegate {
  
  private let songLoader: SongLoader
  
  var presenter: MusicListPresenter?
  
  init(songLoader: SongLoader) {
    self.songLoader = songLoader
  }
  
  func didRequestMusicItems() {
    presenter?.didStartLoading()
    
    songLoader.getSongs { result  in
      switch result {
      case .success(let songs):
        self.presenter?.didFinishLoading(with: songs)
        
      case .failure(let error):
        self.presenter?.didFinishLoading(with: error)
        
      }
    }
    
  }
  
}
