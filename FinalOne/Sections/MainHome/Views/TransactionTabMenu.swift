//
//  TransactionTabMenu.swift
//  V1
//
//  Created by Kaweerut Kanthawong on 6/16/17.
//  Copyright © 2017 Ascend Money Thailand. All rights reserved.
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
            self.setHilightMenu(animated: true)
        }
        get {
            return _selectedIndex
        }
    }
    
    private var prevFrame: CGRect = CGRect.zero
    private let imageItems: [UIImage] = [UIImage(named: "iRecent")!, UIImage(named: "iFavorite")!]
    private let imageItemsSel: [UIImage] = [UIImage(named: "iRecentActive")!, UIImage(named: "iFavoriteActive")!]
    
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
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
        self.prevFrame = frame
        setHilightMenu(animated: false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !frame.equalTo(prevFrame) {
            self.prevFrame = frame
            self.setHilightMenu(animated: false)
        }
    }
    
    private func setHilightMenu(animated: Bool) {
        let updateView = { () -> Swift.Void in
            if self._selectedIndex == 0 {
                self.recentButton.setImage(self.imageItemsSel[0], for: .normal)
                self.recentButton.setTitleColor(UIColor.darkGray, for: .normal)
                self.favoriteButton.setImage(self.imageItems[1], for: .normal)
                self.favoriteButton.setTitleColor(UIColor.lightGray, for: .normal)
            } else {
                self.recentButton.setImage(self.imageItems[0], for: .normal)
                self.recentButton.setTitleColor(UIColor.lightGray, for: .normal)
                self.favoriteButton.setImage(self.imageItemsSel[1], for: .normal)
                self.favoriteButton.setTitleColor(UIColor.darkGray, for: .normal)
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
        if sender.tag != self.selectedIndex {
            self.delegate?.transaction(menu: self, selectedAt: sender.tag)
        }
        self.selectedIndex = sender.tag
    }
}
