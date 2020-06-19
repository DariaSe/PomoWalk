//
//  DropdownMenuView.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 15.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

struct DropdownOption: Equatable {
    var title: String
    var isSelected: Bool
    
    static func ==(lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.title == rhs.title
    }
}

class DropdownMenuView: UIView {
    
    var options: [DropdownOption] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let tableView = UITableView()
    
    var didSelectOption: ((Int) -> Void)?
    
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
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.register(DropdownMenuTableViewCell.self, forCellReuseIdentifier: DropdownMenuTableViewCell.reuseIdentifier)
    }
}

extension DropdownMenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropdownMenuTableViewCell.reuseIdentifier, for: indexPath) as! DropdownMenuTableViewCell
        cell.setupColors()
        let option = options[indexPath.row]
        cell.update(text: option.title, isSelected: option.isSelected)
        return cell
    }
}

extension DropdownMenuView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectOption?(indexPath.row)
    }
}
