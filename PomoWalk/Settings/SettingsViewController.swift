//
//  SettingsViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 11.04.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI

class SettingsViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let settingsLabel = UILabel()
    let warningLabel = UILabel()
    
    let baseSettingsView = BaseSettingsView()
    let soundColorSettingsView = SoundColorSettingsView()
    let policyContactView = PolicyContactView()
    
    let dropdownMenu = MenuView()
    
    let shadowingView = UIView()
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        setupLayout()
        settingsLabel.textAlignment = .center
        settingsLabel.font = UIFont.headerFont
        settingsLabel.textColor = UIColor.textColor
        settingsLabel.text = Strings.settings
        
        warningLabel.textAlignment = .center
        warningLabel.font = UIFont(name: montserratSemiBold, size: 12)
        warningLabel.textColor = UIColor.textColor.withAlphaComponent(0.8)
        warningLabel.numberOfLines = 2
        warningLabel.text = Strings.warning
        
        soundColorSettingsView.delegate = self
        
        policyContactView.showMail = { [unowned self] in
            self.showMail()
        }
        policyContactView.showPrivacyPolicy = { [unowned self] in
            self.showPrivacyPolicy()
        }
        
        UserDefaults.standard.addObserver(self, forKeyPath: SoundColorSettings.colorSchemeKey, options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let intervals = Interval.loadAllFromFile(), !intervals.isEmpty {
            warningLabel.isHidden = false
        }
        else {
            warningLabel.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissMenu()
    }
    
    func setupLayout() {
        scrollView.constrainToLayoutMargins(of: view, leading: 0, trailing: 0, top: 10, bottom: 20)
        stackView.pinToEdges(to: scrollView)
        stackView.setWidth(equalTo: scrollView, multiplier: 0.98)
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.addArrangedSubview(settingsLabel)
        stackView.addArrangedSubview(warningLabel)
        stackView.addArrangedSubview(baseSettingsView)
        stackView.addArrangedSubview(soundColorSettingsView)
        stackView.addArrangedSubview(policyContactView)
        
        shadowingView.pinToEdges(to: view)
        shadowingView.isHidden = true
        shadowingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        view.addSubview(dropdownMenu)
        dropdownMenu.isHidden = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        shadowingView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissMenu() {
        dropdownMenu.isHidden = true
        shadowingView.isHidden = true
        player?.stop()
    }
}

extension SettingsViewController: DropdownDelegate {
    
    func frameForDropdown(sender: UIButton, width: CGFloat, height: CGFloat) -> CGRect {
        let senderOrigin = sender.convert(CGPoint.zero, to: self.view)
        let senderHeight = sender.frame.height
        if (UIScreen.main.bounds.height - senderOrigin.y - 44) < height {
            return CGRect(x: view.bounds.maxX - width - 10, y: senderOrigin.y + senderHeight - height, width: width, height: height)
        }
        else {
            return CGRect(x: view.bounds.maxX - width - 10, y: senderOrigin.y, width: width, height: height)
        }
    }
    
    func playSound(title: String) {
        guard let url = Bundle.main.url(forResource: title, withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            self.player = try? AVAudioPlayer(contentsOf: url)
            guard let player = self.player else { return }
            player.volume = 1
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func showWorkSounds(sender: UIButton) {
        shadowingView.isHidden = false
        dropdownMenu.isHidden = false
        let sounds = SoundColorSettings.workEndSounds
        let dropdownHeight = CGFloat(sounds.count * 44)
        let frame = frameForDropdown(sender: sender, width: 180, height: dropdownHeight)
        dropdownMenu.frame = frame
        dropdownMenu.options = sounds
        dropdownMenu.didSelectOption = { [unowned self] int in
            let selectedSound = sounds[int]
            let title = selectedSound.title.lowercased()
            self.playSound(title: title)
            SoundColorSettings.workEndSound = selectedSound.title.lowercased()
            self.dropdownMenu.options = SoundColorSettings.workEndSounds
            self.soundColorSettingsView.workReminderView.buttonTitle = selectedSound.title.capitalized
        }
    }
    
    func showWalkSounds(sender: UIButton) {
        shadowingView.isHidden = false
        dropdownMenu.isHidden = false
        let sounds = SoundColorSettings.walkEndSounds
        let dropdownHeight = CGFloat(sounds.count * 44)
        let frame = frameForDropdown(sender: sender, width: 180, height: dropdownHeight)
        dropdownMenu.frame = frame
        dropdownMenu.options = sounds
        dropdownMenu.didSelectOption = { [unowned self] int in
            let selectedSound = sounds[int]
            let title = selectedSound.title.lowercased()
            self.playSound(title: title)
            SoundColorSettings.walkEndSound = selectedSound.title.lowercased()
            self.dropdownMenu.options = SoundColorSettings.walkEndSounds
            self.soundColorSettingsView.walkReminderView.buttonTitle = selectedSound.title.capitalized
        }
    }
    
    func showColorSchemes(sender: UIButton) {
        shadowingView.isHidden = false
        dropdownMenu.isHidden = false
        let schemes = SoundColorSettings.colorSchemes
        let dropdownHeight = CGFloat(schemes.count * 44)
        let frame = frameForDropdown(sender: sender, width: 180, height: dropdownHeight)
        dropdownMenu.frame = frame
        dropdownMenu.options = schemes
        dropdownMenu.didSelectOption = { [unowned self] int in
            SoundColorSettings.colorScheme = int
            self.dropdownMenu.options = SoundColorSettings.colorSchemes
            self.soundColorSettingsView.colorSchemeView.buttonTitle = SoundColorSettings.colorSchemes[SoundColorSettings.colorScheme].title
        }
    }
    
    func showMail() {
        let toRecipents = ["pomowalk@gmail.com"]
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients(toRecipents)
        self.present(mailVC, animated: true, completion: nil)
    }
    
    func showPrivacyPolicy() {
        let policyVC = PolicyViewController()
        policyVC.text = Strings.policy
        policyVC.modalPresentationStyle = .overFullScreen
        self.present(policyVC, animated: true)
    }
}

// UserDefaults Observer
extension SettingsViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == SoundColorSettings.colorSchemeKey {
            tabBarController?.tabBar.backgroundColor = UIColor.backgroundColor
            tabBarController?.tabBar.barTintColor = UIColor.backgroundColor
            tabBarController?.tabBar.tintColor = UIColor.textColor
            settingsLabel.textColor = UIColor.textColor
            warningLabel.textColor = UIColor.textColor.withAlphaComponent(0.8)
            view.backgroundColor = UIColor.backgroundColor
            baseSettingsView.setupColors()
            soundColorSettingsView.setupColors()
            dropdownMenu.tableView.reloadData()
            policyContactView.setColors()
        }
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

