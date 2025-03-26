//
//  NotificationHandler.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 06/07/23.
//

import Foundation
import AVKit

struct PlayerDuration {
  let currentTime: Double
  let totalTime: Double
}

extension Notification.Name {
  static let TrackPlayingNotification = Notification.Name(rawValue: "TrackPlayingNotification")
  static let TrackPausedNotification = Notification.Name(rawValue: "TrackPausedNotification")
  static let TrackNotPlayingNotification = Notification.Name(rawValue: "TrackNotPlayingNotification")
  static let TrackDownloadingNotification = Notification.Name(rawValue: "TrackDownloadingNotification")
  static let TrackDurationNotification = Notification.Name(rawValue: "TrackDurationNotification")
  
}

final class NotificationHandler {
  
  private init() {}
  
  static func notifyPlay() {
    NotificationCenter.default.post(name: .TrackPlayingNotification, object: nil)
  }
  
  static func notifyPause() {
    NotificationCenter.default.post(name: .TrackPausedNotification, object: nil)
  }
  
  static func notifyNotPlaying() {
    NotificationCenter.default.post(name: .TrackNotPlayingNotification, object: nil)
  }
  
  static func notifyDownloading() {
    NotificationCenter.default.post(name: .TrackDownloadingNotification, object: nil)
  }
  
  static func notifyDuration(_ duration: PlayerDuration) {
    let object = ["duration": duration]
    NotificationCenter.default.post(name: .TrackDurationNotification, object: object)
  }
  
}
