//
//  SettingsViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 11.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let baseSettingsView = BaseSettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        setupLayout()
    }
    
    func setupLayout() {
        scrollView.pinToEdges(to: view)
        stackView.pinToEdges(to: scrollView, constant: 20)
        stackView.setWidth(equalTo: scrollView, multiplier: -40)
        stackView.axis = .vertical
        stackView.addArrangedSubview(baseSettingsView)
    }
}
