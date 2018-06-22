//
//  MainHomeViewController.swift
//  FinalOne
//
//  Created by Canh Tran on 6/21/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import UIKit
import ViewAnimator

class MainHomeViewController: UIViewController {
    
    // MARK: IBOutlets & Variables
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var tabMenuItems: HomeTabMenu!
    private let animations = [AnimationType.from(direction: .right, offset: UIScreen.main.bounds.width)]
    
    fileprivate var viewModel: HomeListItemViewModel = {
        let viewModel = HomeListItemViewModel(homeSearchService: HomePageServiece())
        return viewModel
    }()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModel()
    }
    
    private func setupView() {
        collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        tabMenuItems.delegate = self
    }
    
    private func setupViewModel() {
        viewModel.listViewDelegate = self
    }
}

// MARK: HomeItemsViewModelDelegate
extension MainHomeViewController: HomeItemsViewModelDelegate {
    
    func listItemsDidChanged() {
        if viewModel.isChangingItems {
            animateRemovingCollectionCells()
        } else {
            animateCollectionCells()
        }
    }
    
    /// Animate collection cells when reloadata
    private func animateCollectionCells() {
        self.collectionView.reloadData()
        self.collectionView.performBatchUpdates({
            UIView.animate(views: self.collectionView.orderedVisibleCells,
                           animations: self.animations,
                           duration: 0.9,
                           springWithDamping: 0.7,
                           velocity: 0.7,
                           options: [.curveEaseInOut],
                           completion: {
            })
        }, completion: nil)
    }
    
    /// Animate removing collection cells
    private func animateRemovingCollectionCells() {
        UIView.animate(views: collectionView.orderedVisibleCells.reversed(),
                       animations: animations,
                       reversed: true,
                       initialAlpha: 1,
                       duration: 0.4,
                       springWithDamping: 0.7,
                       velocity: 0.7,
                       options: [.curveEaseInOut],
                       completion: {
                        self.animateCollectionCells()
        })
    }
}

// MARK: HomeTabMenuDelegate
extension MainHomeViewController: HomeTabMenuDelegate {
    func transaction(menu: HomeTabMenu, selectedType type: ItemsType) {
        viewModel.tabMenuDidChange(withType: type)
    } 
}

// MARK: CollectionViewDataSource
extension MainHomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        if let model = viewModel.itemAtIndex(indexPath.row) {
            cell.setupMovieCellWithModel(model: model)
        } 
        return cell
    }
}

extension MainHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 - 10,
                      height: collectionView.frame.size.height - 10)
    }
}
