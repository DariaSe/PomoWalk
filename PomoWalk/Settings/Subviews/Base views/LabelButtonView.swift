//
//  LabelButtonView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class LabelButtonView: UIView {

   var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    var buttonTitle: String = "" {
        didSet {
            button.setTitle(buttonTitle + " " + "\u{25BC}", for: .normal)
        }
    }
    
    let stackView = UIStackView()
    
    let label = UILabel()
    let button = UIButton()
    
    var buttonPressed: (() -> Void)?
    
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
        stackView.addArrangedSubview(button)
    }
    
    func initialSetup() {
        label.font = UIFont.settingsTextFont
        label.textColor = UIColor.textColor
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        button.titleLabel?.font = UIFont.stepperUnitFont
        button.setTitleColor(UIColor.walkCounterColor, for: .normal)
        button.addTarget(self, action: #selector(viewButtonPressed), for: .touchUpInside)
    }
    
    @objc func viewButtonPressed() {
        buttonPressed?()
    }
    
    func setupColors() {
        label.textColor = UIColor.textColor
        button.setTitleColor(UIColor.walkCounterColor, for: .normal)
    }
}
