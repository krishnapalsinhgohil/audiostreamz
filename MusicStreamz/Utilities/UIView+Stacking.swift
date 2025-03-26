//
//  UIView+Stacking.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 01/07/22.
//

import Foundation
import UIKit


class BaseView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  func setupViews() {}
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
}


fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical,
                        views: [UIView],
                        spacing: CGFloat = 0,
                        alignment: UIStackView.Alignment = .fill,
                        distribution: UIStackView.Distribution = .fill) -> UIStackView {
  
  let stackView = UIStackView(alArrangedSubViews: views)
  stackView.axis = axis
  stackView.spacing = spacing
  stackView.alignment = alignment
  stackView.distribution = distribution
  stackView.backgroundColor = .clear
  return stackView
}

@discardableResult
public func stack(_ views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
  return _stack(.vertical, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
}

@discardableResult
public func hstack(_ views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
  return _stack(.horizontal, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
}


// To add horizontal spacing as margins when individual components need their own padding
class Container: BaseView {
  
  convenience init(horizontal: CGFloat = 0, vertical: CGFloat = 0, view: UIView, applySameBackgroundColor: Bool = false) {
    self.init(frame: .zero)

    
    self.backgroundColor = applySameBackgroundColor ? view.backgroundColor : .clear
    
    let stackView = hstack([view], alignment: .center).withMargins(.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal))
    addSub(Views: [stackView])
    stackView.fillSuperview()

  }
  
  override func setupViews() {
    super.setupViews()
  }
  
}


// To add divider between views with dynamic color and height
class DividerView: BaseView {
  
  override var backgroundColor: UIColor? {
    didSet {
      innerView.backgroundColor = backgroundColor
      
    }
  }
  
  let innerView = UIView()

  var heightConstraint: NSLayoutConstraint?
  
  convenience init(color: UIColor = .gray, height: CGFloat = 0.8,width: CGFloat = 0) {
    self.init(frame: .zero)
    
    backgroundColor = color
    innerView.backgroundColor = color
    heightConstraint = innerView.heightAnchor.constraint(equalToConstant: height)
    heightConstraint?.isActive = true
    
    if width != 0 {
      innerView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    
    let stackView = hstack([innerView], alignment: .center)
    
    addSub(Views: [stackView])
    stackView.fillSuperview()
    
  }
  
  func setHeight(_ height: CGFloat) {
    heightConstraint?.constant = height
  }
  
  override func setupViews() {
    super.setupViews()
  }
  
}
