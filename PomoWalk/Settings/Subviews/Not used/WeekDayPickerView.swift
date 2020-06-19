//
//  WeekDayPickerView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 16.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class WeekDayPickerView: UIView {
    
    // MARK: - API
    
    func setTitleColor(color: UIColor, for state: UIControl.State) {
        switch state {
        case .normal:
            for button in buttons {
                button.setTitleColor(color, for: .normal)
            }
        case .highlighted:
            for button in buttons {
                button.setTitleColor(color, for: .highlighted)
            }
        default:
            break
            
        }
    }
    
    var selectedWeekDays: [Int] = []
    
    var selectedColor: UIColor = .lightGray
    var deselectedColor: UIColor = .gray
    
    var font: UIFont = UIFont(name: montserratBold, size: 12)!
    
    var daysSelected: (([Int]) -> Void)?
    
    // MARK: - UI Elements
    
    let buttons = [RoundButton(), RoundButton(), RoundButton(), RoundButton(), RoundButton(), RoundButton(), RoundButton()]
    
    let stackView = UIStackView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setupLayout()
    }
    
    func setupLayout() {
        stackView.pinToEdges(to: self)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        for button in buttons {
            stackView.addArrangedSubview(button)
            button.setWidth(equalTo: 38)
            button.setEqualHeight()
        }
    }
    
    func initialSetup() {
        setupLayout()
        let weekDays = Calendar.current.localWeekdaySymbols
        for (index, button) in buttons.enumerated() {
            let title = String(weekDays[index].prefix(2))
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(weekDayChosen(sender:)), for: .touchUpInside)
            button.tag = index
        }
        updateButtons()
    }
    
    func updateButtons() {
        for (index, button) in buttons.enumerated() {
            button.titleLabel?.font = font
            if selectedWeekDays.contains(index) {
                button.backgroundColor = selectedColor
                button.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .normal)
            }
            else {
                button.backgroundColor = deselectedColor.withAlphaComponent(0.3)
                button.setTitleColor(selectedColor, for: .normal)
            }
        }
    }
    
    @objc func weekDayChosen(sender: UIButton) {
        if selectedWeekDays.contains(sender.tag) {
            selectedWeekDays = selectedWeekDays.filter{ $0 != sender.tag }
        }
        else {
            selectedWeekDays.append(sender.tag)
        }
        updateButtons()
        daysSelected?(selectedWeekDays)
    }

}
