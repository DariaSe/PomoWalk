//
//  LabelSwitchView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 13.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LabelSwitchView: UIView {
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    let stackView = UIStackView()
    
    let label = UILabel()
    let switchh = UISwitch()
    
    var valueSet: ((Bool) -> Void)?
    
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
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(switchh)
    }
    
    func initialSetup() {
        label.font = UIFont.settingsTextFont
        label.textColor = UIColor.textColor
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        
        switchh.onTintColor = UIColor.walkCounterColor.withAlphaComponent(0.4)
        switchh.thumbTintColor = UIColor.workCounterColor
        switchh.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @objc func valueChanged() {
        valueSet?(switchh.isOn)
    }
    
    func setupColors() {
        label.textColor = UIColor.textColor
        switchh.onTintColor = UIColor.walkCounterColor.withAlphaComponent(0.6)
        switchh.thumbTintColor = UIColor.workCounterColor
    }
    
}
