//
//  MusicUIComposer.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 28/06/23.
//

import Foundation

protocol MusicFeedLoadingDelegate {
  func didRequestMusicItems()
}

protocol ImageLoadingDelegate {
  func didRequestImage()
  func didCancelImageRequest()

}

final class MusicUIComposer {
  
  private init() {}
  
  static func composedWith(
    songLoader: SongLoader,
    imageLoader: ImageLoader,
    queueManager: QueueManager,
    trackPlayer: TrackPlayer
  ) -> MusicViewController {
    
    let musicViewController = MusicViewController()
    musicViewController.title = "Music"

    let musicListPresentationAdapter = MusicListPresenterAdapter(songLoader: songLoader)
    musicListPresentationAdapter.presenter = MusicListPresenter(
      view: MusicViewAdapter(
        controller: musicViewController,
        imageLoader: imageLoader,
        queueManager: queueManager,
        trackPlayer: trackPlayer
      ),
      errorView: WeakRefVirtualProxy(musicViewController),
      loadingView: WeakRefVirtualProxy(musicViewController)
    )
    
    let refreshController = MusicRefereshController(delegate: musicListPresentationAdapter)
    musicViewController.refreshController = refreshController
    musicViewController.delegate = musicListPresentationAdapter
    
    return musicViewController
  
  }
  
}
