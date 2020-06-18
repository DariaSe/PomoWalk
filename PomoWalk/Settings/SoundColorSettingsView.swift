//
//  SoundColorSettingsView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class SoundColorSettingsView: UIView {
    
    let stackView = UIStackView()
    let workReminderView = LabelButtonView()
    let walkReminderView = LabelButtonView()
    let vibrationView = LabelSwitchView()
    let colorSchemeView = LabelButtonView()
    
    var delegate: DropdownDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        stackView.pinToEdges(to: self)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(workReminderView)
        stackView.addArrangedSubview(walkReminderView)
        stackView.addArrangedSubview(vibrationView)
        stackView.addArrangedSubview(colorSchemeView)
    }
    
    private func initialSetup() {
        
        workReminderView.text = Strings.workReminder
        workReminderView.buttonTitle = SoundColorSettings.workEndSound.capitalized
        workReminderView.buttonPressed = { [unowned self] in
            self.delegate?.showWorkSounds(sender: self.workReminderView.button)
        }
        walkReminderView.text = Strings.walkReminder
        walkReminderView.buttonTitle = SoundColorSettings.walkEndSound.capitalized
        walkReminderView.buttonPressed = { [unowned self] in
            self.delegate?.showWalkSounds(sender: self.walkReminderView.button)
        }
        vibrationView.text = Strings.vibration
        vibrationView.switchh.isOn = SoundColorSettings.isVibrationOn
        vibrationView.valueSet = { bool in
            SoundColorSettings.isVibrationOn = bool
        }
        colorSchemeView.text = Strings.colorScheme
        colorSchemeView.buttonTitle = SoundColorSettings.colorSchemes[SoundColorSettings.colorScheme].title
        colorSchemeView.buttonPressed = { [unowned self] in
            self.delegate?.showColorSchemes(sender: self.colorSchemeView.button)
        }
    }
    
    func setupColors() {
        workReminderView.setupColors()
        walkReminderView.setupColors()
        vibrationView.setupColors()
        colorSchemeView.setupColors()
    }
}

protocol DropdownDelegate {
    func showWorkSounds(sender: UIButton)
    func showWalkSounds(sender: UIButton)
    func showColorSchemes(sender: UIButton)
}
