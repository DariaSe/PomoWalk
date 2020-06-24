//
//  MenuView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct MenuOption: Equatable {
    var title: String
    var isSelected: Bool
    
    static func ==(lhs: MenuOption, rhs: MenuOption) -> Bool {
        return lhs.title == rhs.title
    }
}

class MenuView: UIView {
    
    var options: [MenuOption] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var isEditable: Bool = false
    
    let tableView = UITableView()
    
    var didSelectOption: ((Int) -> Void)?
    var didDeleteOption: ((Int) -> Void)?
    var textChanged: ((String, Int) -> Void)?
    
    var editingRow: Int? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetup() {
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        tableView.pinToEdges(to: self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.bounces = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseIdentifier)
    }
}

extension MenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier, for: indexPath) as! MenuTableViewCell
        cell.setupColors()
        cell.isEditable = indexPath.row == editingRow
        let option = options[indexPath.row]
        cell.update(text: option.title, isSelected: option.isSelected)
        cell.textChanged = { [unowned self] text in
            self.textChanged?(text, indexPath.row)
        }
        return cell
    }
}

extension MenuView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectOption?(indexPath.row)
        editingRow = nil
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isEditable && indexPath.row != editingRow
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: Strings.edit) { [unowned self] (_, indexPath) in
            self.editingRow = indexPath.row
        }
        editAction.backgroundColor = UIColor.backgroundCompanionColor
        let deleteAction = UITableViewRowAction(style: .destructive, title: Strings.delete) { [unowned self] (_, indexPath) in
            self.didDeleteOption?(indexPath.row)
        }
        return [deleteAction, editAction]
    }
}

