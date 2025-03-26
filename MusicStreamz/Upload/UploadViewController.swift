//
//  UploadViewController.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 21/06/23.
//

import UIKit
import UniformTypeIdentifiers

protocol AudioUploadDelegate {
  func uploadFiles(from urls: [URL])
}

class UploadViewController: BaseViewController {
  
  var delegate: AudioUploadDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let image = UIImage(systemName: "plus.circle.fill")
    
    navigationItem.rightBarButtonItem = .init(image: image, style: .plain, target: self, action: #selector(addButtonTapped))
    navigationItem.rightBarButtonItem?.tintColor = .themeBackground
    
  }
  
  @objc func addButtonTapped() {
    let types = UTType.types(tag: "mp3",
                             tagClass: UTTagClass.filenameExtension,
                             conformingTo: nil)
    let documentPickerController = UIDocumentPickerViewController(forOpeningContentTypes: types)
    documentPickerController.delegate = self
    documentPickerController.allowsMultipleSelection = true
    showDetailViewController(documentPickerController, sender: nil)

  }
  
}

extension UploadViewController: UIDocumentPickerDelegate {
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    delegate?.uploadFiles(from: urls)
    
  }
  
  func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    print(">> Document picker closed")
  }
  
}
