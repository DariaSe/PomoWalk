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
        scrollView.pinToLayoutMargins(to: view)
        stackView.pinToEdges(to: scrollView)
        stackView.setWidth(equalTo: scrollView)
        stackView.axis = .vertical
        stackView.addArrangedSubview(baseSettingsView)
    }
}
