//
//  MusicViewController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

class MusicViewController: BaseViewController {
  
  var refreshController: MusicRefereshController?
  var delegate: MusicFeedLoadingDelegate?
  
  private(set) lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.showsVerticalScrollIndicator = false
    tableView.delegate = self
    return tableView
  }()
  
  private lazy var tableViewDataSource:
  UITableViewDiffableDataSource<UUID, CellController> = {
    let dataSource = UITableViewDiffableDataSource<UUID, CellController>(tableView: tableView) { tableView, indexPath, itemIdentifier in
      return itemIdentifier.dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
    return dataSource
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    view.addSubview(tableView)
    tableView.refreshControl = refreshController?.view
    tableView.fillSuperview()
    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableView.automaticDimension
    
    tableView.register(TrackInfoListCell.self, forCellReuseIdentifier: TrackInfoListCell.identifier)
    tableView.dataSource = tableViewDataSource
    delegate?.didRequestMusicItems()
    
    NotificationCenter.default.addObserver(
      forName: .TrackPlayingNotification,
      object: nil,
      queue: nil
    ) { [weak self] _ in
      self?.tableView.reloadData()
    }
    
    NotificationCenter.default.addObserver(
      forName: .TrackNotPlayingNotification,
      object: nil,
      queue: nil
    ) { [weak self] _ in
      self?.tableView.reloadData()

    }
    
    NotificationCenter.default.addObserver(
      forName: .TrackPausedNotification,
      object: nil,
      queue: nil
    ) { [weak self] _ in
      self?.tableView.reloadData()
    }
    
    NotificationCenter.default.addObserver(
      forName: .TrackDownloadingNotification,
      object: nil,
      queue: nil
    ) { [weak self] _ in
      self?.tableView.reloadData()
    }
    
    
  }
  
  func configure(with items: [CellController]) {
    var snapshot = NSDiffableDataSourceSnapshot<UUID, CellController>()
    let main = UUID()
    snapshot.appendSections([main])
    snapshot.appendItems(items, toSection: main)
    tableViewDataSource.apply(snapshot, animatingDifferences: false)
  }
  
}

extension MusicViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView,
                 willDisplay cell: UITableViewCell,
                 forRowAt indexPath: IndexPath) {
    cellController(for: indexPath)?.delegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
  }
  
  func tableView(_ tableView: UITableView,
                 didEndDisplaying cell: UITableViewCell,
                 forRowAt indexPath: IndexPath) {
    cellController(for: indexPath)?.delegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
  }
  
  
  private func cellController(for rowAt: IndexPath) -> CellController? {
    return tableViewDataSource.itemIdentifier(for: rowAt)
  }
}

extension MusicViewController: ResourceErrorView, ResourceLoadingView {

  func display(viewModel: Error?) {

  }

  func display(viewModel: Bool) {
    viewModel ? refreshController?.view.beginRefreshing() : refreshController?.view.endRefreshing()
  }

}

extension TrackInfoListCell {
  
  func set(viewModel: TrackViewModel) {
    trackLabel.attributedText = .songDetails(from: viewModel.name, artist: viewModel.artist)
  }
  
}

