//
//  SongSliderContainerView.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 07/07/23.
//

import UIKit

class SongSliderContainerView: BaseView {
  private lazy var currentDurationLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textColor = .lightGray
    label.text = "0:00"
    label.font = .systemFont(ofSize: 14)
    return label
  }()

  private lazy var totalDurationLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.textColor = .lightGray
    label.text = "-3:46"
    label.font = .systemFont(ofSize: 14)
    return label
  }()

  private lazy var songSliderView: UISlider = {
    let sliderView = UISlider()
    sliderView.tintColor = .themeBackground
    return sliderView
  }()

  
  override func setupViews() {
    super.setupViews()
    
    addSubviews(songSliderView, currentDurationLabel, totalDurationLabel)
    
    songSliderView.anchor(topAnchor, left: leftAnchor, right: rightAnchor)
    
    currentDurationLabel.anchor(songSliderView.bottomAnchor, left: songSliderView.leftAnchor, bottom: bottomAnchor, topConstant: 0)
    
    totalDurationLabel.anchor(currentDurationLabel.topAnchor, bottom: bottomAnchor, right: songSliderView.rightAnchor)
    
  }
  
  func set(duration: Double, totalDuration: Double) {
    songSliderView.minimumValue = 0
    songSliderView.maximumValue = (Float(totalDuration) / 100).isNaN ? 0.0 : Float(totalDuration) / 100
    
    songSliderView.value = Float(duration) / 100
    currentDurationLabel.text = getString(from: duration)
    totalDurationLabel.text = getString(from: totalDuration)
    
  }
  
  private func getString(from time: Double) -> String {
      let minutes = time.isNaN ? 0 : Int(time / 60)
    let remainingSeconds = time.isNaN ? 0 : Int(time) % 60
    return String(format: "%02d:%02d", minutes, remainingSeconds)
  }
}
