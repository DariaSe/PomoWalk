//
//  BaseSettingsView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 13.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class BaseSettingsView: UIView {
    
    let stackView = UIStackView()
    let longPauseStackView = UIStackView()
    
    let longPauseContainerView = UIView()
    
    let workDurationView = LabelStepperView()
    let walkDurationView = LabelStepperView()
    
    let longPauseSwitchView = LabelSwitchView()
    let longPauseDurationView = LabelStepperView()
    let longPausePeriodsView = LabelStepperView()
    let isPrereminderSetView = LabelSwitchView()
    let continueAutomaticallyView = LabelSwitchView()
    
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
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        longPauseStackView.axis = .vertical
        stackView.addArrangedSubview(workDurationView)
        stackView.addArrangedSubview(walkDurationView)
        stackView.addArrangedSubview(longPauseSwitchView)
        stackView.addArrangedSubview(longPauseContainerView)
        longPauseStackView.constrainToEdges(of: longPauseContainerView, leading: 40, trailing: 0, top: 0, bottom: 0)
        longPauseStackView.addArrangedSubview(longPauseDurationView)
        longPauseStackView.addArrangedSubview(longPausePeriodsView)
        stackView.addArrangedSubview(isPrereminderSetView)
        stackView.addArrangedSubview(continueAutomaticallyView)
    }
    
    func initialSetup() {
        workDurationView.firstText = "Work for".localized
        workDurationView.secondText = "minutes".localized
        workDurationView.stepperUnit.minValue = 15
        workDurationView.stepperUnit.maxValue = 60
        workDurationView.stepperUnit.step = 5
        workDurationView.stepperUnit.value = BaseSettings.workIntervalDuration
        workDurationView.stepperUnit.valueSet = { value in
            BaseSettings.workIntervalDuration = value
        }
        walkDurationView.firstText = "Walk for".localized
        walkDurationView.secondText = "minutes".localized
        walkDurationView.stepperUnit.minValue = 2
        walkDurationView.stepperUnit.maxValue = 10
        walkDurationView.stepperUnit.alwaysShowsTwoDigits = false
        walkDurationView.stepperUnit.value = BaseSettings.walkIntervalDuration
        walkDurationView.stepperUnit.valueSet = { value in
            BaseSettings.walkIntervalDuration = value
        }
        longPauseSwitchView.text = "Long pause".localized
        longPauseSwitchView.switchh.isOn = BaseSettings.isLongPausePlanned
        longPauseSwitchView.valueSet = { [weak self] bool in
            BaseSettings.isLongPausePlanned = bool
            self?.longPauseDurationView.isHidden = !bool
            self?.longPausePeriodsView.isHidden = !bool
        }
        if !BaseSettings.isLongPausePlanned {
            longPauseDurationView.isHidden = true
            longPausePeriodsView.isHidden = true
        }
        longPauseDurationView.firstText = ""
        longPauseDurationView.secondText = "minutes".localized
        longPauseDurationView.stepperUnit.minValue = 5
        longPauseDurationView.stepperUnit.maxValue = 20
        longPauseDurationView.stepperUnit.alwaysShowsTwoDigits = false
        longPauseDurationView.stepperUnit.value = BaseSettings.longPauseDuration
        longPauseDurationView.stepperUnit.valueSet = { value in
            BaseSettings.longPauseDuration = value
        }
        longPausePeriodsView.firstText = "after".localized
        longPausePeriodsView.secondText = "work intervals".localized
        longPausePeriodsView.stepperUnit.minValue = 2
        longPausePeriodsView.stepperUnit.maxValue = 5
        longPausePeriodsView.stepperUnit.alwaysShowsTwoDigits = false
        longPausePeriodsView.stepperUnit.value = BaseSettings.longPauseAfter
        longPausePeriodsView.stepperUnit.valueSet = { value in
            BaseSettings.longPauseAfter = value
        }
        isPrereminderSetView.text = "Signal 1 minute before end".localized
        isPrereminderSetView.switchh.isOn = BaseSettings.isPrereminderSet
        isPrereminderSetView.valueSet = { bool in
            BaseSettings.isPrereminderSet = bool
        }
        continueAutomaticallyView.text = "Continue automatically".localized
        continueAutomaticallyView.switchh.isOn = BaseSettings.isAutoContinued
        continueAutomaticallyView.valueSet = { bool in
            BaseSettings.isAutoContinued = bool
        }
    }
    
}
