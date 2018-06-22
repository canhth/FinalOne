//
//  ItemCell.swift
//  FinalOne
//
//  Created by Canh Tran on 6/22/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import UIKit

/// This protocol using for TabMenu selection
protocol HomeTabMenuDelegate: class {
    func transaction(menu: HomeTabMenu, selectedType type: ItemsType)
}

/// Enum of TabMenu type
enum ItemsType: Int {
    case apples = 0
    case androids = 1
}

class HomeTabMenu: UIView {
    
    // MARK: IBOutlets & Variables
    @IBOutlet fileprivate weak var appleButton: UIButton!
    @IBOutlet fileprivate weak var androidButton: UIButton!
    @IBOutlet fileprivate weak var indyView: UIView!
    @IBOutlet fileprivate weak var indyLeftConts: NSLayoutConstraint!
    @IBOutlet fileprivate weak var menuBottomLine: UIView!
    
    private let animateDuration: TimeInterval = 0.5
    public weak var delegate: HomeTabMenuDelegate?
    
    private var _selectedIndex: Int = 0
    public var selectedIndex: Int {
        set {
            if newValue < 0 || newValue > 1 {
                return
            }
            _selectedIndex = newValue
            setHilightMenu(animated: true)
        }
        get {
            return _selectedIndex
        }
    }
    
    private var prevFrame: CGRect = CGRect.zero
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !frame.equalTo(prevFrame) {
            prevFrame = frame
            setHilightMenu(animated: false)
        }
    }
    
    private func setHilightMenu(animated: Bool) {
        let updateView = { () -> Swift.Void in
            if self._selectedIndex == 0 {
                self.appleButton.setTitleColor(UIColor.white, for: .normal)
                self.androidButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                self.appleButton.setTitleColor(UIColor.white, for: .normal)
                self.androidButton.setTitleColor(UIColor.white, for: .normal)
            }
            self.indyLeftConts.constant = CGFloat(self._selectedIndex) * (self.frame.width * 0.5)
            self.layoutIfNeeded()
        }
        
        if animated {
            UIView.animate(withDuration: animateDuration, animations: {
                self.indyLeftConts.constant = CGFloat(self._selectedIndex) * (self.frame.width*0.5)
                self.layoutIfNeeded()
            }) { _ in }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + animateDuration + 0.02) {
                updateView()
            }
        } else {
            updateView()
        }
    }

    @IBAction private func menuButtonTapped(_ sender: UIButton) {
        if sender.tag != selectedIndex {
            self.delegate?.transaction(menu: self, selectedType: ItemsType(rawValue: sender.tag) ?? .apples)
        }
        selectedIndex = sender.tag
    }
}
