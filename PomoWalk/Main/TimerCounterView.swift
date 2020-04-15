//
//  TimerCounterView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 10.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class TimerCounterView: UIView {
    
    var percentRemaining: CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var type: ActivityType = .work {
        didSet {
            setNeedsDisplay()
        }
    }

    
    var counterColor: UIColor {
        switch self.type {
        case .work:
            return UIColor.workCounterColor
        case .walk:
            return UIColor.walkCounterColor
        }
    }
    
    var traceColor: UIColor {
        return counterColor.withAlphaComponent(0.3)
    }
    
    override func draw(_ rect: CGRect) {
        let arcWidth: CGFloat = bounds.width / 6
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = self.bounds.width / 2 - arcWidth/2
        let endAngle: CGFloat = 3 * .pi / 2
        let tracePath = UIBezierPath(ovalIn: CGRect(x: arcWidth / 2, y: arcWidth / 2, width: bounds.width - arcWidth, height: bounds.height - arcWidth))
        tracePath.lineWidth = arcWidth
        traceColor.setStroke()
        tracePath.stroke()
        
        let circleLength: CGFloat = 2 * .pi
        let counterStartAngle = endAngle - circleLength * percentRemaining
        let counterPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: counterStartAngle, endAngle: endAngle, clockwise: true)
        counterPath.lineWidth = arcWidth
        counterColor.setStroke()
        counterPath.stroke()
    }
    
}
