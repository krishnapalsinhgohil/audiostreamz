//
//  CellController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 23/06/23.
//

import UIKit

struct CellController {
  let id: UUID
  let dataSource: UITableViewDataSource
  let delegate: UITableViewDelegate?
  
  init(id: UUID, datasource: UITableViewDataSource) {
    self.id = id
    self.dataSource = datasource
    self.delegate = datasource as? UITableViewDelegate
    
  }
  
}

extension CellController: Equatable {
  static func == (lhs: CellController, rhs: CellController) -> Bool {
    return lhs.id == rhs.id
  }

}

extension CellController: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

}
