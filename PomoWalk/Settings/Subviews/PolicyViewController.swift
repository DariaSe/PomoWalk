//
//  PolicyViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 04.07.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class PolicyViewController: UIViewController {
    
    var text: String = "" {
        didSet {
            infoTextView.text = text
        }
    }
    
    private let containerView = UIView()
    
    private let stackView = UIStackView()
    
    private let infoTextView = UITextView()
    private let okButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.pinToEdges(to: view)
        
        containerView.center(in: view)
        containerView.setWidth(equalTo: view, multiplier: 0.9)
        containerView.setHeight(equalTo: view, multiplier: 0.9)
        containerView.backgroundColor = UIColor.backgroundColor
        containerView.layer.cornerRadius = 20
        
        stackView.pinToLayoutMargins(to: containerView)
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.addArrangedSubview(infoTextView)
        stackView.addArrangedSubview(okButton)
        
        infoTextView.backgroundColor = UIColor.backgroundColor
        infoTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        infoTextView.isEditable = false
        infoTextView.font = UIFont.settingsTextFont
        infoTextView.textColor = UIColor.textColor.withAlphaComponent(0.8)

        okButton.setHeight(equalTo: 40)
        okButton.layer.cornerRadius = 16
        okButton.backgroundColor = UIColor.walkCounterColor
        okButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
        okButton.titleLabel?.font = UIFont.buttonsFont
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }
    
    @objc func okButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
