//
//  PolicyContactView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 04.07.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class PolicyContactView: UIView {
    
    private let stackView = UIStackView()
    
    private let contactButton = UIButton()
    private let policyButton = UIButton()
    
    var showMail: (() -> Void)?
    var showPrivacyPolicy: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        stackView.pinToEdges(to: self)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.addArrangedSubview(contactButton)
        stackView.addArrangedSubview(policyButton)
        
        contactButton.setTitle(Strings.contact, for: .normal)
        contactButton.titleLabel?.font = UIFont.buttonsFont
        contactButton.setTitleColor(UIColor.walkCounterColor, for: .normal)
        contactButton.addTarget(self, action: #selector(contactButtonPressed), for: .touchUpInside)
        
        policyButton.setTitle(Strings.privacyPolicy, for: .normal)
        policyButton.setTitleColor(UIColor.walkCounterColor, for: .normal)
        policyButton.titleLabel?.font = UIFont.buttonsFont
        policyButton.addTarget(self, action: #selector(policyButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func contactButtonPressed() {
        contactButton.animate(scale: 1.05)
        showMail?()
    }
    
    @objc func policyButtonPressed() {
        policyButton.animate(scale: 1.05)
        showPrivacyPolicy?()
    }
    
    func setColors() {
        contactButton.setTitleColor(UIColor.walkCounterColor, for: .normal)
        policyButton.setTitleColor(UIColor.walkCounterColor, for: .normal)
    }
}
