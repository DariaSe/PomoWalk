//
//  TasksViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 21.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, KeyboardHandler {
    
    var options: [MenuOption] = [] {
        didSet {
            menuView.options = options
            emptyLabel.isHidden = !options.isEmpty
            menuView.isHidden = options.isEmpty
        }
    }
    
    var delegate: MenuDelegate?
    
    let tasksLabel = UILabel()
    
    let tableViewContainer = UIView()
    let addButton = UIButton()
    let menuView = MenuView()
    
    let emptyLabel = UILabel()
    
    var isEditable: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        registerForKeyboardNotifications(for: menuView.tableView)
        tableViewContainer.center(in: view)
        tableViewContainer.setWidth(equalTo: view, multiplier: 0.8)
        tableViewContainer.setHeight(equalTo: view, multiplier: 0.6)
        
        tasksLabel.constrainToEdges(of: tableViewContainer, leading: 60, trailing: 60, top: 20, bottom: nil)
        tasksLabel.textAlignment = .center
        tasksLabel.textColor = UIColor.textColor
        tasksLabel.font = UIFont.stepperUnitFont
        tasksLabel.text = Strings.tasks

        addButton.constrainToEdges(of: tableViewContainer, leading: nil, trailing: 10, top: 10, bottom: nil)
        addButton.setSize(width: 40, height: 40)
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(UIColor.textColor, for: .normal)
        addButton.titleLabel?.font = UIFont(name: montserratSemiBold, size: 32)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        emptyLabel.center(in: tableViewContainer)
        emptyLabel.text = Strings.noTasks
        emptyLabel.font = UIFont.settingsTextFont
        emptyLabel.textColor = UIColor.textColor.withAlphaComponent(0.8)
        
        menuView.constrainToEdges(of: tableViewContainer, leading: 0, trailing: 0, top: 60, bottom: 10)
        menuView.isEditable = isEditable
        menuView.backgroundColor = UIColor.clear
        
        menuView.didSelectOption = { [unowned self] index in
            self.delegate?.didSelectOption(index: index)
        }
        menuView.didDeleteOption = { [unowned self] index in
            self.delegate?.deleteOption(index: index)
        }
        menuView.textChanged = { [unowned self] text, index in
            self.delegate?.optionChanged(text: text, index: index)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissOnTap))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewContainer.backgroundColor = UIColor.backgroundColor
    }
    
    @objc func addButtonPressed() {
        delegate?.addButtonPressed()
    }
    
    @objc func dismissOnTap() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TasksViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

protocol MenuDelegate {
    func addButtonPressed()
    func didSelectOption(index: Int)
    func optionChanged(text: String, index: Int)
    func deleteOption(index: Int)
}
