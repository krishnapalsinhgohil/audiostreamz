//
//  BaseViewController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(">> Allocated \(classForCoder)")
    setupViews()
  }
  
  func setupViews() {}
  
  deinit {
    print(">> Deallocated \(classForCoder)")
  }
  
  
}
