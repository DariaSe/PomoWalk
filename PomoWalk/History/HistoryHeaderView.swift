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
    let lowerLine = UIView()
    let horizontalLine = UIView()
    
    let dateLabel = UILabel()
    
    let pomodoroStackView = UIStackView()
    let pomodoroImageView = UIImageView()
    let pomodoroImage = UIImage(named: "Tomato")?.withRenderingMode(.alwaysTemplate)
    let pomodorosLabel = UILabel()
    
    let stepsStackView = UIStackView()
    let stepsImageView = UIImageView()
    let stepsImage = UIImage(named: "Steps")?.withRenderingMode(.alwaysTemplate)
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
        
        lowerLine.constrainToEdges(of: self, leading: 20, trailing: nil, top: 46, bottom: 0)
        lowerLine.setWidth(equalTo: 1)
        lowerLine.backgroundColor = linesColor
        
        circle.centerVertically(in: self, leading: nil, trailing: nil)
        circle.centerXAnchor.constraint(equalTo: lowerLine.centerXAnchor).isActive = true
        circle.setSize(width: 10, height: 10)
        circle.layer.cornerRadius = 5
        circle.backgroundColor = UIColor.backgroundCompanionColor
        
        dateLabel.centerVertically(in: self, leading: 55, trailing: 20)
        dateLabel.font = UIFont.stepperUnitFont
        dateLabel.textColor = UIColor.backgroundCompanionColor
        
        pomodoroStackView.constrainToEdges(of: self, leading: 55, trailing: nil, top: nil, bottom: 5)
        pomodoroStackView.axis = .horizontal
        pomodoroStackView.spacing = 10
        pomodoroStackView.addArrangedSubview(pomodoroImageView)
        pomodoroStackView.addArrangedSubview(pomodorosLabel)
        pomodoroImageView.setSize(width: 20, height: 20)
        pomodoroImageView.tintColor = UIColor.workCounterColor
        pomodoroImageView.image = pomodoroImage
        pomodorosLabel.font = UIFont.stepperUnitFont
        pomodorosLabel.textColor = UIColor.backgroundCompanionColor
        
        stepsStackView.constrainToEdges(of: self, leading: nil, trailing: 20, top: nil, bottom: 5)
        stepsStackView.axis = .horizontal
        stepsStackView.spacing = 10
        stepsStackView.addArrangedSubview(stepsImageView)
        stepsStackView.addArrangedSubview(stepsLabel)
        stepsImageView.setSize(width: 20, height: 20)
        stepsImageView.tintColor = UIColor.walkCounterColor
        stepsImageView.image = stepsImage
        stepsLabel.font = UIFont.stepperUnitFont
        stepsLabel.textColor = UIColor.backgroundCompanionColor
    }
}
