//
//  MusicViewAdapter.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 28/06/23.
//

import Foundation

final class MusicViewAdapter: MusicView {
  private weak var controller: MusicViewController?
  private let imageLoader: ImageLoader
  private let queueManager: QueueManager
  private let trackPlayer: TrackPlayer
    
  init(
    controller: MusicViewController,
    imageLoader: ImageLoader,
    queueManager: QueueManager,
    trackPlayer: TrackPlayer
  ) {
    self.controller = controller
    self.imageLoader = imageLoader
    self.trackPlayer = trackPlayer
    self.queueManager = queueManager
  }
  
  
  func display(viewModel: [Song]) {
    controller?.configure(with: viewModel.map { song in
      let model = TrackViewModel(id: song.id, name: song.name, artist: song.artist, albumURL: song.albumURL)
      
      let adapter = MusicFeedImagePresentationAdapter(url: song.albumURL, imageLoader: imageLoader)
      
      let musicAudioAdapter = MusicAudioStreamerPresentationAdapter(song: song, trackPlayer: trackPlayer, queueManager: queueManager)
            
      let trackController = TrackCellController(viewModel: model,
                                                imageLoader: adapter,
                                                audioStreamer: musicAudioAdapter)
      
      musicAudioAdapter.presenter = MusicAudioStreamPresenter(
        resourceView: WeakRefVirtualProxy(trackController),
        loadingView: WeakRefVirtualProxy(trackController),
        errorView: WeakRefVirtualProxy(trackController)
      )
      
      adapter.presenter = MusicFeedImagePresenter(
        view: WeakRefVirtualProxy(trackController),
        loadingView: WeakRefVirtualProxy(trackController),
        errorView: WeakRefVirtualProxy(trackController)
      )
      
      return CellController(id: UUID(), datasource: trackController)
      
    })
  }
  
}

struct MusicAudioViewModel {
  enum TrackPlayingState { case playing, paused, `default`, downloading }
  let state: TrackPlayingState
}

struct MusicAudioErrorViewModel {}
struct MusicAudioLoadingViewModel {}

protocol MusicAudioView {
  func display(_ viewModel: MusicAudioViewModel)
}

protocol MusicAudioErrorView {
  func display(_ viewModel: MusicAudioErrorViewModel)
}

protocol MusicAudioLoadingView {
  func display(_ viewModel: MusicAudioLoadingViewModel)
}

class MusicAudioStreamPresenter {
  let resourceView: MusicAudioView
  let loadingView: MusicAudioLoadingView
  let errorView: MusicAudioErrorView
  
  init(resourceView: MusicAudioView,
       loadingView: MusicAudioLoadingView,
       errorView: MusicAudioErrorView) {
    self.resourceView = resourceView
    self.loadingView = loadingView
    self.errorView = errorView
  }
  
  func didStartDownloading() {
    resourceView.display(.init(state: .downloading))
  }
  
  func didStartPlaying() {
    resourceView.display(.init(state: .playing))
  }
  
  func didStopPlaying() {
    resourceView.display(.init(state: .default))
  }
  
  func didPausePlaying() {
    resourceView.display (.init(state: .paused))
  }
  
}

class MusicAudioStreamerPresentationAdapter: MusicFeedAudioPlayingDelegate {
  
  var presenter: MusicAudioStreamPresenter?
  
  private let song: Song
  private let trackPlayer: TrackPlayer
  private let queueManager: QueueManager

  init(song: Song,
       trackPlayer: TrackPlayer,
       queueManager: QueueManager) {
    self.trackPlayer = trackPlayer
    self.song = song
    self.queueManager = queueManager
    
  }
  
  func getState() {
    guard queueManager.getCurrentSong() == song else {
      presenter?.didStopPlaying()
      return
    }

    switch trackPlayer.getState() {
    case .playing:
      presenter?.didStartPlaying()

    case .paused:
      presenter?.didPausePlaying()

    case .downloading:
      presenter?.didStartDownloading()

    case .default:
      presenter?.didStopPlaying()
      
    }
  }
  
  
  func playMusic() {
    queueManager.add(song: song)

    if let url = URL(string: song.downloadURL) {
      trackPlayer.play(url: url)
    }
   
  }
  
  func pauseMusic() {
    trackPlayer.pause()
  }
  
  
}
