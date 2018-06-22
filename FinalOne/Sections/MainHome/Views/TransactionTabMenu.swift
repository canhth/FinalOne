//
//  ItemCell.swift
//  FinalOne
//
//  Created by Canh Tran on 6/22/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import UIKit

protocol TransactionTabMenuDelegate: class {
    func transaction(menu: TransactionTabMenu, selectedAt index: Int)
}

class TransactionTabMenu: UIView {
    private let animateDuration: TimeInterval = 0.2
    
    public weak var delegate: TransactionTabMenuDelegate?
    
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
    
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var androidButton: UIButton!
    @IBOutlet weak var indyView: UIView!
    @IBOutlet weak var indyLeftConts: NSLayoutConstraint!
    @IBOutlet weak var menuBottomLine: UIView!
    
    init() {
        super.init(frame: CGRect())
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupView()
    }
    
    private func setupView() {
        prevFrame = frame
        setHilightMenu(animated: false)
    }
    
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
                self.appleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                self.androidButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            } else {
                self.appleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                self.androidButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
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

    @IBAction func menuButtonTapped(_ sender: UIButton) {
        if sender.tag != selectedIndex {
            self.delegate?.transaction(menu: self, selectedAt: sender.tag)
        }
        selectedIndex = sender.tag
    }
}
