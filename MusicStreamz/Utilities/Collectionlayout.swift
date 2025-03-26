//
//  Collectionlayout.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

final class Collectionlayout {
  
  static var ExploreLayout: UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2.15),
                                           heightDimension: .estimated(200))
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                   subitems: [item])
    
    group.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                  leading: 0,
                                                  bottom: 0,
                                                  trailing: 15)
    
    let section = NSCollectionLayoutSection(group: group)
    
    section.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                    leading: 15,
                                                    bottom: 10,
                                                    trailing: 0)
    
    section.orthogonalScrollingBehavior = .continuous
    
    section.boundarySupplementaryItems = [
      .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)), elementKind: "Header", alignment: .top),
      .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(1)), elementKind: "Footer", alignment: .top)
    ]
    
    return UICollectionViewCompositionalLayout(section: section)
  }
    
}
