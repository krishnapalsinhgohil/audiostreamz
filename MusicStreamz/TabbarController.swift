//
//  TabbarController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

class TabbarController: UITabBarController {
  private var miniPlayerViewController: MiniPlayerViewController!
  
  var didUpdateFrame: ((CGRect) -> Void)?
  
  init(miniPlayerViewController: MiniPlayerViewController) {
    self.miniPlayerViewController = miniPlayerViewController
    super.init(nibName: nil, bundle: nil)

  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.tintColor = .themeBackground
    tabBar.isTranslucent = false
    tabBar.backgroundColor = .white

    guard let playerView = miniPlayerViewController.miniPlayerView else {return}
    
    view.addSubview(playerView)
    playerView.anchor(left: view.leftAnchor, bottom: tabBar.topAnchor, right: view.rightAnchor)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    didUpdateFrame?(miniPlayerViewController.miniPlayerView?.frame ?? .zero)
  }
  
}

