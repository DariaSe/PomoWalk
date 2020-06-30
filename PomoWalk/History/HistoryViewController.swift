//
//  HistoryViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 21.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var coordinator: HistoryCoordinator?
    
    var intervals: [[Interval]] = [[]] {
        didSet {
            emptyLabel.isHidden = !intervals.isEmpty
            tableView.isHidden = intervals.isEmpty
            tableView.reloadData()
        }
    }
 
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    let emptyLabel = UILabel()
    
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        
        emptyLabel.center(in: view)
        emptyLabel.text = Strings.noHistory
        emptyLabel.numberOfLines = 3
        emptyLabel.font = UIFont.stepperUnitFont
        emptyLabel.textColor = UIColor.textColor.withAlphaComponent(0.8)
        
        tableView.constrainTopAndBottomToLayoutMargins(of: view, leading: 0, trailing: 0, top: 10, bottom: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.backgroundColor
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        tableView.isHidden = true
        
        UserDefaults.standard.addObserver(self, forKeyPath: SoundColorSettings.colorSchemeKey, options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.getInfo()
        coordinator?.getTasks()
    }
}

extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return intervals.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intervals[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath) as! HistoryTableViewCell
        cell.update(with: intervals[indexPath.section][indexPath.row])
        if indexPath.row == intervals[indexPath.section].count - 1 {
            cell.lowerLine.backgroundColor = UIColor.clear
        }
        else {
            cell.lowerLine.backgroundColor = cell.linesColor
        }
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !intervals.isEmpty, !intervals[section].isEmpty else { return nil }
        let header = HistoryHeaderView()
        header.backgroundColor = UIColor.backgroundColor
        dateFormatter.dateStyle = .medium
        header.dateText = dateFormatter.string(from: intervals[section].first!.endDate)
        let totalSteps = intervals[section]
            .filter { $0.activityType != ActivityType.work.rawValue }
            .compactMap {$0.steps}
            .reduce(0) { $0 + $1 }
        header.stepsText = Strings.totalSteps + totalSteps.string
        header.upperLine.backgroundColor = UIColor.clear
        return header
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let interval = intervals[indexPath.section][indexPath.row]
        let delete = UITableViewRowAction(style: .destructive, title: Strings.delete) { [unowned self] (_, _) in
            self.coordinator?.askDeletion(interval)
        }
        if interval.activityType == ActivityType.work.rawValue {
            let edit = UITableViewRowAction(style: .normal, title: Strings.edit) { [unowned self] (_, _) in
                self.coordinator?.showTasks(for: interval)
            }
            edit.backgroundColor = UIColor.backgroundCompanionColor
            return [delete, edit]
        }
        else {
            return [delete]
        }
    }
}

extension HistoryViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == SoundColorSettings.colorSchemeKey {
            view.backgroundColor = UIColor.backgroundColor
            tableView.backgroundColor = UIColor.backgroundColor
            tableView.reloadData()
        }
    }
}
