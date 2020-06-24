//
//  BadgesViewController.swift
//  PomoWalk
//
//  Created by Дарья Селезнёва on 18.06.2020.
//  Copyright © 2020 dariaS. All rights reserved.
//

import UIKit

class BadgesViewController: UIViewController {
    
    weak var coordinator: BadgesCoordinator?
    
    var badges: [[Badge]] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var headers: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let badgesLabel = UILabel()
    
    let stepsUnavailableLabel = UILabel()
    
    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    }()
    
    let collectionViewLayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor
        badgesLabel.constrainTopAndBottomToLayoutMargins(of: view, leading: 0, trailing: 0, top: 10, bottom: nil)
        badgesLabel.textAlignment = .center
        badgesLabel.font = UIFont.headerFont
        badgesLabel.textColor = UIColor.textColor
        badgesLabel.text = Strings.badges
        
        stepsUnavailableLabel.center(in: view)
        stepsUnavailableLabel.textColor = UIColor.textColor
        stepsUnavailableLabel.font = UIFont.settingsTextFont
        stepsUnavailableLabel.textAlignment = .center
        stepsUnavailableLabel.numberOfLines = 3
        stepsUnavailableLabel.text = Strings.stepsUnavailable
        
        collectionView.constrainTopAndBottomToLayoutMargins(of: view, leading: 10, trailing: 10, top: nil, bottom: 20)
        collectionView.topAnchor.constraint(equalTo: badgesLabel.bottomAnchor).isActive = true
        collectionView.backgroundColor = UIColor.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BadgeCollectionViewCell.self, forCellWithReuseIdentifier: BadgeCollectionViewCell.reuseIdentifier)
        collectionView.register(BadgesCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BadgesCollectionReusableView.reuseIdentifier)
        
        UserDefaults.standard.addObserver(self, forKeyPath: SoundColorSettings.colorSchemeKey, options: .new, context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.start()
    }
}

extension BadgesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.reuseIdentifier, for: indexPath) as! BadgeCollectionViewCell
        let badge = badges[indexPath.section][indexPath.row]
        cell.update(with: badge)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BadgesCollectionReusableView.reuseIdentifier, for: indexPath) as! BadgesCollectionReusableView
        header.label.textColor = UIColor.textColor
        header.text = headers[indexPath.section]
        return header
    }
}

extension BadgesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 20) / 5 - 7
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension BadgesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 80)
    }
}



// UserDefaults Observer
extension BadgesViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == SoundColorSettings.colorSchemeKey {
            view.backgroundColor = UIColor.backgroundColor
            badgesLabel.textColor = UIColor.textColor
            stepsUnavailableLabel.textColor = UIColor.textColor
            collectionView.backgroundColor = UIColor.backgroundColor
            collectionView.reloadData()
        }
    }
}

