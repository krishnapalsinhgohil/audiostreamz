//
//  TrackCellController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import UIKit

protocol MusicFeedAudioPlayingDelegate {
  func playMusic()
  func pauseMusic()
  func getState()
}

protocol MusicFeedImageLoadingDelegate {
  func didRequestImage()
  func didCancelRequest()
}

class TrackCellController: NSObject, UITableViewDataSource, UITableViewDelegate {
  
  private let viewModel: TrackViewModel
  private let imageLoader: MusicFeedImageLoadingDelegate
  private let audioStreamer: MusicFeedAudioPlayingDelegate
  private var cell: TrackInfoListCell?
  
  init(viewModel: TrackViewModel,
       imageLoader: MusicFeedImageLoadingDelegate,
       audioStreamer: MusicFeedAudioPlayingDelegate
  ) {
    self.viewModel = viewModel
    self.imageLoader = imageLoader
    self.audioStreamer = audioStreamer
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    cell = tableView.dequeueReusableCell(withIdentifier: TrackInfoListCell.identifier, for: indexPath) as? TrackInfoListCell
    cell?.set(viewModel: viewModel)
    audioStreamer.getState()
    
    cell?.onReuse = { [weak self] in
      self?.releaseCellForReuse()
    }

    cell?.onTapPlay = { [weak self] in
      self?.audioStreamer.playMusic()
    }
    
    cell?.onTapPause = { [weak self] in
      self?.audioStreamer.pauseMusic()
    }
    
    imageLoader.didRequestImage()
    return cell!
  }

  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    releaseCellForReuse()
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    self.cell = (cell as? TrackInfoListCell)
    imageLoader.didRequestImage()
    audioStreamer.getState()

  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  private func releaseCellForReuse() {
    imageLoader.didCancelRequest()
    cell = nil
  }
  
}

extension TrackCellController: MusicFeedView, ResourceLoadingView, ResourceErrorView {
  func display(viewModel: Bool) {
    if viewModel {
      cell?.posterImageView.showLoading()
    }else {
      cell?.posterImageView.hideLoading()
    }
  }
  
  func display(viewModel: Error?) {
    cell?.posterImageView.image = UIImage()
  }
  
  func display(_ viewModel: MusicImageViewModel) {
    cell?.posterImageView.image = UIImage(data: viewModel.image)
  }
  
}


extension TrackCellController: MusicAudioView,
                               MusicAudioLoadingView,
                               MusicAudioErrorView {
  func display(_ viewModel: MusicAudioViewModel) {
    cell?.loadingIndicator.isHidden = true
    cell?.backgroundColor = .clear

    switch viewModel.state {
    case .playing:
      cell?.playingState()

    case .paused:
      cell?.pausedState()
      
    case .default:
      cell?.defaultState()
      
    case .downloading:
      cell?.downloadingState()
      

    }
    
  }
  
  func display(_ viewModel: MusicAudioLoadingViewModel) {
    
  }
  
  func display(_ viewModel: MusicAudioErrorViewModel) {
    
  }
  
}
