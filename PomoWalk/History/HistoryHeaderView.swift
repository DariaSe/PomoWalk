//
//  HistoryHeaderView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 21.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class HistoryHeaderView: UIView {
    
    var dateText: String = "" {
        didSet {
            dateLabel.text = dateText
        }
    }
    
    var stepsText: String = "" {
        didSet {
            stepsLabel.text = stepsText
        }
    }
    
    let circle = UIView()
    let upperLine = UIView()
    let lowerLine = UIView()
    let horizontalLine = UIView()
    let dateLabel = UILabel()
    let stepsLabel = UILabel()
    
    var linesColor: UIColor = UIColor.backgroundCompanionColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        horizontalLine.centerVertically(in: self, leading: 20, trailing: nil)
        horizontalLine.setWidth(equalTo: 30)
        horizontalLine.setHeight(equalTo: 1)
        horizontalLine.backgroundColor = linesColor
        
        upperLine.constrainToEdges(of: self, leading: 20, trailing: nil, top: 0, bottom: 33)
        upperLine.setWidth(equalTo: 1)
        upperLine.backgroundColor = linesColor
        
        lowerLine.constrainToEdges(of: self, leading: 20, trailing: nil, top: 33, bottom: 0)
        lowerLine.setWidth(equalTo: 1)
        lowerLine.backgroundColor = linesColor
        
        circle.centerVertically(in: self, leading: nil, trailing: nil)
        circle.centerXAnchor.constraint(equalTo: upperLine.centerXAnchor).isActive = true
        circle.setSize(width: 10, height: 10)
        circle.layer.cornerRadius = 5
        circle.backgroundColor = UIColor.backgroundCompanionColor
        
        dateLabel.centerVertically(in: self, leading: 55, trailing: 20)
        dateLabel.font = UIFont.stepperUnitFont
        dateLabel.textColor = UIColor.backgroundCompanionColor
        
        stepsLabel.constrainToEdges(of: self, leading: 55, trailing: 20, top: nil, bottom: 5)
        stepsLabel.font = UIFont.historyTimeFont
        stepsLabel.textColor = UIColor.backgroundCompanionColor
    }
}
