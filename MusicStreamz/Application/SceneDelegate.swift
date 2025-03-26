//
//  SceneDelegate.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  private let trackPlayer = TrackPlayer()
  private let queueManager = QueueManager()

  private var tabBarController: TabbarController?
  
  private var miniPlayerViewController: MiniPlayerViewController {
    let miniPlayerViewController = MiniPlayerViewController(trackPlayer: trackPlayer, queueManager: queueManager, openPlayer: presentPlayerView)
    return miniPlayerViewController
  }
  
  private var imageLoader: ImageLoader {
    let loader = ImageLoaderComposite(primary: LocalImageLoader(),
                                      fallback: ImageLoadingServiceAdapter())
    return GuaranteeMainQueue(loader)
  }
  
  var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.makeKeyAndVisible()
    
    window?.rootViewController = makeTabbarController()
    
  }
  
  private func makeTabbarController() -> UITabBarController {
    tabBarController = TabbarController(miniPlayerViewController: miniPlayerViewController)
    
    tabBarController?.viewControllers = [
      createMusicViewController().withTabBarImage(image: Constants.navMusic),
      SearchViewController().withTabBarImage(image: Constants.navSearch),
      createUploadViewController().withTabBarImage(image: Constants.navProfile)
    ]
    
    return tabBarController!
  }
  
  private func presentPlayerView() {
    let playerViewController = PlayerUIComposer.composedWith(
      player: trackPlayer,
      queueManager: queueManager,
      imageLoader: imageLoader
    )
    
    window?.rootViewController?.present(playerViewController, animated: true)
    
  }
  
  private func createUploadViewController() -> UIViewController {
    return UINavigationController(rootViewController: UploadViewComposer.composedWith())
  }
  
  private func createMusicViewController() -> UIViewController {
    
    let musicViewController = MusicUIComposer.composedWith(
      songLoader: RemoteSongLoader(),
      imageLoader: imageLoader,
      queueManager: queueManager,
      trackPlayer: trackPlayer
    )
    
    tabBarController?.didUpdateFrame = { [weak musicViewController] frame in
      musicViewController?.tableView.contentInset = .init(top: 0, left: 0, bottom: frame.height + 8, right: 0)

    }
    
    
    return UINavigationController(rootViewController: musicViewController)
  }

}

