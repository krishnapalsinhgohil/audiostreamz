//
//  Extension+StackView.swift
//  MusicStreamz
//
//  Created by Krishnapalsinh Gohil on 12/05/22.
//

import Foundation
import UIKit

extension UIStackView {
    public convenience init(alArrangedSubViews: [UIView]) {
        alArrangedSubViews.forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        self.init(arrangedSubviews: alArrangedSubViews)
    }
    
    func addStackSubView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(view)
    }
    
    func insertStackSubView(_ view: UIView, at index: Int) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.insertArrangedSubview(view, at: index)
    }
    
    
    fileprivate func _padSides(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        
        if let top = top {
            layoutMargins = .init(top: top, left: layoutMargins.left, bottom: layoutMargins.bottom, right: layoutMargins.right)
        }
        
        if let left = left {
            layoutMargins = .init(top: layoutMargins.top, left: left, bottom: layoutMargins.bottom, right: layoutMargins.right)
        }
        
        if let bottom = bottom {
            layoutMargins = .init(top: layoutMargins.top, left: layoutMargins.left, bottom: bottom, right: layoutMargins.right)
        }
        
        if let right = right {
            layoutMargins = .init(top: layoutMargins.top, left: layoutMargins.left, bottom: layoutMargins.bottom, right: right)
        }
        
        return self
    }
    
    @discardableResult
    func withMargins(_ layoutMargins: UIEdgeInsets) -> UIStackView {
        return _padSides(top: layoutMargins.top, left: layoutMargins.left, bottom: layoutMargins.bottom, right: layoutMargins.right)
    }
    
    @discardableResult
    func padTop(_ topSpacing: CGFloat) -> UIStackView {
        return _padSides(top: topSpacing)
    }
    
    @discardableResult
    func padLeft(_ leftSpacing: CGFloat) -> UIStackView {
        return _padSides(left: leftSpacing)
    }
    
    @discardableResult
    func padRight(_ rightSpacing: CGFloat) -> UIStackView {
        return _padSides(right: rightSpacing)
    }
    
    @discardableResult
    func padBottom(_ bottomSpacing: CGFloat) -> UIStackView {
        return _padSides(bottom: bottomSpacing)
    }
    
    @discardableResult
    func padHorizontalSymmetric(_ spacing: CGFloat) -> UIStackView {
        return _padSides(left: spacing, right: spacing)
    }
    
    @discardableResult
    func padVerticalSymmetric(_ spacing: CGFloat) -> UIStackView {
        return _padSides(top: spacing, bottom: spacing)
    }
    
    @discardableResult
    func withBackgroundColor(color: UIColor) -> UIStackView {
        if #available(iOS 14.0, *) {
            backgroundColor = color
            
        }else{
            let backgroundView = UIView(frame: self.bounds)
            backgroundView.backgroundColor = color
            backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(backgroundView, at: 0)
            
        }
        
        return self
    }
  
    @discardableResult
    func withBackgroundImage(_ image: String, alpha: CGFloat = 1.0) -> UIStackView {
      let imageView = UIImageView(frame: self.bounds)
      imageView.image = image.toImage()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.alpha = alpha
      imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      insertSubview(imageView, at: 0)
      return self
    }
    
  
}
///*****
//MARK:UIStackView
public extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],axis: NSLayoutConstraint.Axis,spacing: CGFloat = 0.0,alignment: UIStackView.Alignment = .fill,distribution:UIStackView.Distribution = .fill) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
          removeArrangedSubview(view)
          view.removeFromSuperview()
        }
    }
    
}
