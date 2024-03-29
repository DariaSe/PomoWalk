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
            if alwaysShowsTwoDigits {
                label.text = String(format: "%02i", value)
            }
            else {
                label.text = String(value)
            }
        }
    }
    
    var alwaysShowsTwoDigits: Bool = true
    
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
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
    
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
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        leftButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        leftButton.tintColor = UIColor.walkCounterColor
        leftButton.setHeight(equalTo: 30)
        leftButton.setEqualWidth()

        rightButton.setImage(rightImage, for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        rightButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        rightButton.tintColor = UIColor.walkCounterColor
        rightButton.setHeight(equalTo: 30)
        rightButton.setEqualWidth()
    }
    
    @objc func increment() {
        if value <= (maxValue - step) {
            value += step
        }
        else {
            value = minValue
        }
        rightButton.animate(scale: 1.2)
        valueSet?(value)
    }
    
    @objc func decrement() {
        if value > minValue {
            value -= step
        }
        else {
            value = maxValue
        }
        leftButton.animate(scale: 1.2)
        valueSet?(value)
    }
    
    func setupColors() {
        label.textColor = UIColor.walkCounterColor
        leftButton.tintColor = UIColor.walkCounterColor
        rightButton.tintColor = UIColor.walkCounterColor
    }
}
