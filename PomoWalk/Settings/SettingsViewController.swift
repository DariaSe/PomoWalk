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
    let scheduleSettingsView = ScheduleSettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
//        baseSettingsView.constrainToEdges(of: view, leading: 20, trailing: 20, top: 20, bottom: nil)
        setupLayout()

        
    }
    
    func setupLayout() {
        scrollView.pinToEdges(to: view)
        stackView.pinToActualEdges(of: scrollView, constant: 20)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        stackView.axis = .vertical
        stackView.addArrangedSubview(baseSettingsView)
        stackView.addArrangedSubview(scheduleSettingsView)
    }

   
}
