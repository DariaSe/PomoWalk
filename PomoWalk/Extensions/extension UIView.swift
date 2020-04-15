//
//  extension UIView.swift
//  Trigo
//
//  Created by Дарья Селезнёва on 05/10/2019.
//  Copyright © 2019 dariaS. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToEdges(to superview: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor).isActive = true
    }
    
    func pinToEdges(to superview: UIView, constant: CGFloat) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
        self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -constant).isActive = true
    }
    
    func constrainToEdges(of superview: UIView, leading: CGFloat, trailing: CGFloat, top: CGFloat?, bottom: CGFloat?) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor, constant: -bottom).isActive = true
        }
    }
    
    func pinToActualEdges(of superview: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
    
    func pinToActualEdges(of superview: UIView, constant: CGFloat) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
    }
    
    func center(in superview: UIView) {
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func setSize(width: CGFloat?, height: CGFloat?) {
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
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

