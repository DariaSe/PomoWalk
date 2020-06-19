//
//  BadgeView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 18.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class BadgeView: UIView {
    
    var percent: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var counterColor: UIColor = UIColor.walkCounterColor
    var traceColor: UIColor = UIColor.walkCounterColor.withAlphaComponent(0.3)

    override func draw(_ rect: CGRect) {
        let arcWidth: CGFloat = bounds.width / 6
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = self.bounds.width / 2 - arcWidth/2
        let startAngle: CGFloat = 3 * .pi / 2
        let tracePath = UIBezierPath(ovalIn: CGRect(x: arcWidth / 2, y: arcWidth / 2, width: bounds.width - arcWidth, height: bounds.height - arcWidth))
        tracePath.lineWidth = arcWidth
        traceColor.setStroke()
        tracePath.stroke()
        
        let circleLength: CGFloat = 2 * .pi
        let counterEndAngle = startAngle + circleLength * percent
        let counterPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: counterEndAngle, clockwise: true)
        counterPath.lineWidth = arcWidth
        counterColor.setStroke()
        counterPath.stroke()
    }
}
