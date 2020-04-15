//
//  protocol SizeAnimatable.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 13.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

protocol SizeAnimatable where Self: UIView {
    func animate(scale: CGFloat)
}

extension SizeAnimatable {
    func animate(scale: CGFloat) {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { (_) in
            self.transform = CGAffineTransform.identity
        }
    }
}

extension UIButton: SizeAnimatable { }

