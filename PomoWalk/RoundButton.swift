//
//  RoundButton.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 10.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        layer.cornerRadius = self.bounds.height / 2
        layer.shadowPath = UIBezierPath(ovalIn: bounds).cgPath
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
