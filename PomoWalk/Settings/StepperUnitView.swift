//
//  StepperUnitView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 13.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class StepperUnitView: UIView {

    let stackView = UIStackView()
    
    let label = UILabel()
    
    let leftButton = UIButton()
    let rightButton = UIButton()
    
    let leftImage = UIImage(named: "SolidArrowLeft")?.withRenderingMode(.alwaysTemplate)
    let rightImage = UIImage(named: "SolidArrowRight")?.withRenderingMode(.alwaysTemplate)
    
    var maxValue: Int = 60
    var minValue: Int = 0
    var step: Int = 1
    var value: Int = 0 {
        didSet {
            label.text = String(value)
        }
    }
    
    var valueSet: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        stackView.pinToEdges(to: self)
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        
//        leftButton.setSize(width: 30, height: 60)
//        leftButton.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
//        rightButton.setSize(width: 30, height: 60)
//        rightButton.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(rightButton)
    }
    
    func initialSetup() {
        label.text = String(value)
        label.font = UIFont.stepperUnitFont
        label.textColor = UIColor.walkCounterColor
        label.textAlignment = .center
        
        leftButton.setImage(leftImage, for: .normal)
        leftButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        leftButton.tintColor = UIColor.walkCounterColor

        rightButton.setImage(rightImage, for: .normal)
        rightButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        rightButton.tintColor = UIColor.walkCounterColor
    }
    
    @objc func increment() {
        if value < (maxValue - step) {
            value += step
        }
        else {
            value = minValue
        }
        rightButton.animate(scale: 1.2)
        valueSet?(value)
    }
    
    @objc func decrement() {
        if value >= step {
            value -= step
        }
        else {
            value = maxValue - step
        }
        leftButton.animate(scale: 1.2)
        valueSet?(value)
    }
}
