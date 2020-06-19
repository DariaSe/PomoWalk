//
//  ScheduleUnitView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 14.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ScheduleUnitView: UIView {

    var text: String = "" {
        didSet {
            label.text = text
        }
    }
   
    let stackView = UIStackView()
    let unitsStackView = UIStackView()
    
    let label = UILabel()
    let hoursStepperUnit = StepperUnitView()
    let minutesStepperUnit = StepperUnitView()
    
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
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        unitsStackView.axis = .horizontal
        unitsStackView.spacing = 20
        hoursStepperUnit.setWidth(equalTo: 80)
        minutesStepperUnit.setHeight(equalTo: 80)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(unitsStackView)
        unitsStackView.addArrangedSubview(hoursStepperUnit)
        unitsStackView.addArrangedSubview(minutesStepperUnit)
    }
    
    func initialSetup() {
        label.font = UIFont.settingsTextFont
        label.textColor = UIColor.textColor
    }
}
