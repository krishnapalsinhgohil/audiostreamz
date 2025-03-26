//
//  PlayerUIComposer.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 07/07/23.
//

import Foundation
import UIKit

final class PlayerUIComposer {
  
  private init() {}
  
  static func composedWith(player: TrackPlayer,
                           queueManager: QueueManager,
                           imageLoader: ImageLoader) -> UIViewController {
    
    let adapter = PlayerPresentationAdapter(
      player: player,
      queueManager: queueManager)
    
    let imageLoadingAdapter = PlayerImageDownloadAdapter(imageLoader: imageLoader)
    
    let playerViewController = PlayerViewController()
    adapter.imageDelegate = imageLoadingAdapter

    playerViewController.playerDelegate = adapter
    
    imageLoadingAdapter.presenter = MusicFeedImagePresenter(
      view: WeakRefVirtualProxy(playerViewController),
      loadingView: WeakRefVirtualProxy(playerViewController),
      errorView: WeakRefVirtualProxy(playerViewController))
    
    adapter.presenter = PlayerViewPresenter(
      resourceView: WeakRefVirtualProxy(playerViewController),
      errorView: WeakRefVirtualProxy(playerViewController),
      loadingView: WeakRefVirtualProxy(playerViewController))
  
    return UINavigationController(rootViewController: playerViewController)
    
  }
  
}


