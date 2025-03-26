//
//  SectionItemViewModel.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import Foundation

struct SectionItemViewModel {
  let title: String
  let items: [AlbumItemViewModel]
  
  static let items: [SectionItemViewModel] = [
    SectionItemViewModel(title: "Hots now", items: [
      AlbumItemViewModel(name: "Summer Vibes", followers: "1300231", imageURL: ""),
      AlbumItemViewModel(name: "Rap Zone", followers: "650321", imageURL: ""),
      AlbumItemViewModel(name: "Summer Vibes", followers: "25587", imageURL: ""),
    ]),

    SectionItemViewModel(title: "Mood", items: [
      AlbumItemViewModel(name: "Shower Time", followers: "1300255", imageURL: ""),
      AlbumItemViewModel(name: "Old School", followers: "300324", imageURL: ""),
      AlbumItemViewModel(name: "New Times", followers: "87788", imageURL: ""),
    ]),
    
    SectionItemViewModel(title: "Popular artists", items: [
      AlbumItemViewModel(name: "Summer Vibes", followers: "1300231", imageURL: ""),
      AlbumItemViewModel(name: "Rap Zone", followers: "650321", imageURL: ""),
      AlbumItemViewModel(name: "Summer Vibes", followers: "25587", imageURL: ""),
    ])

  ]
  
}

