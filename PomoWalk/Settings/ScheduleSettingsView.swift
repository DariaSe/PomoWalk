//
//  ScheduleSettingsView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 14.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class ScheduleSettingsView: UIView {
    
    let baseStackView = UIStackView()
    
    let isScheduledView = LabelSwitchView()
    
    let scheduleContainerView = UIView()
    let scheduleStackView = UIStackView()
    
    let scheduleStartView = ScheduleUnitView()
    let scheduleEndView = ScheduleUnitView()
    
    let isLunchPlannedView = LabelSwitchView()
    
    let lunchStartView = ScheduleUnitView()
    let lunchEndView = ScheduleUnitView()
    
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
        baseStackView.pinToEdges(to: self)
        baseStackView.axis = .vertical
        baseStackView.addArrangedSubview(isScheduledView)
        baseStackView.addArrangedSubview(scheduleContainerView)
        
        scheduleStackView.constrainToEdges(of: scheduleContainerView, leading: 40, trailing: 0, top: 0, bottom: 0)
        scheduleStackView.axis = .vertical
        scheduleStackView.addArrangedSubview(scheduleStartView)
        scheduleStackView.addArrangedSubview(scheduleEndView)
        
        scheduleStackView.addArrangedSubview(isLunchPlannedView)
        
        scheduleStackView.addArrangedSubview(lunchStartView)
        scheduleStackView.addArrangedSubview(lunchEndView)
        
        if !ScheduleSettings.isScheduled {
            scheduleContainerView.isHidden = true
        }
        if !ScheduleSettings.isLunchPlanned {
            lunchStartView.isHidden = true
            lunchEndView.isHidden = true
        }

    }
    
    func initialSetup() {
        isScheduledView.text = "Schedule notifications"
        isScheduledView.switchh.isOn = ScheduleSettings.isScheduled
        isScheduledView.valueSet = { [weak self] bool in
            ScheduleSettings.isScheduled = bool
            self?.scheduleContainerView.isHidden = !bool
        }
        
        scheduleStartView.text = "From"
        scheduleStartView.hoursStepperUnit.value = ScheduleSettings.scheduleStartHour
        scheduleStartView.minutesStepperUnit.value = ScheduleSettings.scheduleStartMinute
        scheduleStartView.hoursStepperUnit.valueSet = { value in
            ScheduleSettings.scheduleStartHour = value
        }
        scheduleStartView.minutesStepperUnit.valueSet = { value in
            ScheduleSettings.scheduleStartMinute = value
        }
        
        scheduleEndView.text = "To"
        scheduleEndView.hoursStepperUnit.value = ScheduleSettings.scheduleEndHour
        scheduleEndView.minutesStepperUnit.value = ScheduleSettings.scheduleEndMinute
        scheduleEndView.hoursStepperUnit.valueSet = { value in
            ScheduleSettings.scheduleEndHour = value
        }
        scheduleEndView.minutesStepperUnit.valueSet = { value in
            ScheduleSettings.scheduleEndMinute = value
        }
        
        isLunchPlannedView.text = "Lunch pause"
        isLunchPlannedView.switchh.isOn = ScheduleSettings.isLunchPlanned
        isLunchPlannedView.valueSet = { [weak self] bool in
            ScheduleSettings.isLunchPlanned = bool
            self?.lunchStartView.isHidden = !bool
            self?.lunchEndView.isHidden = !bool
        }
        
        lunchStartView.text = "From"
        lunchStartView.hoursStepperUnit.value = ScheduleSettings.lunchStartHour
        lunchStartView.minutesStepperUnit.value = ScheduleSettings.lunchStartMinute
        lunchStartView.hoursStepperUnit.valueSet = { value in
            ScheduleSettings.lunchStartHour = value
        }
        lunchStartView.minutesStepperUnit.valueSet = { value in
            ScheduleSettings.lunchStartMinute = value
        }
        
        lunchEndView.text = "To"
        lunchEndView.hoursStepperUnit.value = ScheduleSettings.lunchEndHour
        lunchEndView.minutesStepperUnit.value = ScheduleSettings.lunchEndMinute
        lunchEndView.hoursStepperUnit.valueSet = { value in
            ScheduleSettings.lunchEndHour = value
        }
        lunchEndView.minutesStepperUnit.valueSet = { value in
            ScheduleSettings.lunchEndMinute = value
        }
    }
    
}
