//
//  ExploreViewController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

class ExploreViewController: BaseViewController {
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: Collectionlayout.ExploreLayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsVerticalScrollIndicator = false
    return collectionView
  }()
  
  private let cellID = "cell"
  
  private let items = SectionItemViewModel.items
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    view.addSubview(collectionView)
    collectionView.fillSuperview()
    
    collectionView.register(AlbumPosterCell.self,
                            forCellWithReuseIdentifier: cellID)
    
    collectionView.register(SectionHeaderView.self,
                            forSupplementaryViewOfKind: "Header",
                            withReuseIdentifier: SectionHeaderView.identifier)
    
    collectionView.register(UICollectionReusableView.self,
                            forSupplementaryViewOfKind: "Footer",
                            withReuseIdentifier: "Footer")
  }
  
}

extension ExploreViewController: UICollectionViewDelegate,
                                 UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return items[section].items.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlbumPosterCell
    let viewModel = items[indexPath.section].items[indexPath.item]
    cell.set(viewModel: viewModel)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == "Header" {
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
      header.set(viewModel: items[indexPath.section])
      return header
      
    }else {
      let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
      return footer
      
    }
    
  }
  
}


extension SectionHeaderView {
  func set(viewModel: SectionItemViewModel) {
    titleLabel.text = viewModel.title
    
  }

}


extension AlbumPosterCell {
  
  func set(viewModel: AlbumItemViewModel) {
    let attributedText = NSMutableAttributedString(
      string: "\(viewModel.name)\n",
      attributes: [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .bold),
        NSAttributedString.Key.foregroundColor : UIColor.black
      ]
    )
    
    attributedText.append(NSAttributedString(
      string: "\(viewModel.followers) FOLLOWERS",
      attributes: [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
        NSAttributedString.Key.foregroundColor : UIColor.lightGray
      ]
    ))
    
    posterLabel.attributedText = attributedText

  }

}
