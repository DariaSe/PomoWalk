//
//  extension UIView.swift
//  Trigo
//
//  Created by Дарья Селезнёва on 05/10/2019.
//  Copyright © 2019 dariaS. All rights reserved.
//

import UIKit

extension UIView {
    
   func pinToEdges(to superview: UIView, constant: CGFloat = 0) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
    }
    
    func pinToLayoutMargins(to superview: UIView, constant: CGFloat = 0) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -constant).isActive = true
        self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -constant).isActive = true
    }
    
    func constrainToLayoutMargins(of superview: UIView, leading: CGFloat?, trailing: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor, constant: -trailing).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -bottom).isActive = true
        }
    }
    
    func constrainToEdges(of superview: UIView, leading: CGFloat?, trailing: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
        }
    }
    
    func pinTopAndBottomToLayoutMargins(to superview: UIView, constant: CGFloat = 0) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -constant).isActive = true
    }
    
    func constrainTopAndBottomToLayoutMargins(of superview: UIView, leading: CGFloat?, trailing: CGFloat?, top: CGFloat?, bottom: CGFloat?) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -bottom).isActive = true
        }
    }
    
    
    func center(in superview: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func centerInSafeArea(in superview: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.layoutMarginsGuide.centerYAnchor).isActive = true
    }
    
    func setSize(width: CGFloat, height: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(equalTo view: UIView, multiplier: CGFloat = 1) {
        self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
    }
    
    func setHeight(equalTo view: UIView, multiplier: CGFloat = 1) {
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
    }
    
    func setWidth(equalTo constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func setHeight(equalTo constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func setEqualHeight() {
        self.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func setEqualWidth() {
        self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}

extension UIView {
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        return nil
    }
}

