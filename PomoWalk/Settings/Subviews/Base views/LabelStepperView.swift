//
//  LabelStepperView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 13.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LabelStepperView: UIView {
    
    var firstText: String = "" {
        didSet {
            firstLabel.text = firstText
        }
    }
    var secondText: String = "" {
        didSet {
            secondLabel.text = secondText
        }
    }
    
    let stackView = UIStackView()
    let subStackView = UIStackView()
    
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    let stepperUnit = StepperUnitView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        stackView.pinToEdges(to: self)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stepperUnit.setWidth(equalTo: 70)
        subStackView.axis = .horizontal
        subStackView.spacing = 20
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(subStackView)
        subStackView.addArrangedSubview(stepperUnit)
        subStackView.addArrangedSubview(secondLabel)
    }
    
    func initialSetup() {
        firstLabel.font = UIFont.settingsTextFont
        firstLabel.textColor = UIColor.textColor
        firstLabel.adjustsFontSizeToFitWidth = true
        firstLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        
        secondLabel.font = UIFont.settingsTextFont
        secondLabel.textColor = UIColor.textColor
        secondLabel.adjustsFontSizeToFitWidth = true
        secondLabel.numberOfLines = 2
        secondLabel.textAlignment = .right
    }
    
    func setupColors() {
        firstLabel.textColor = UIColor.textColor
        secondLabel.textColor = UIColor.textColor
        stepperUnit.setupColors()
    }
}
