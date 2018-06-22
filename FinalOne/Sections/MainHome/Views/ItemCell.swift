//
//  ItemCell.swift
//  FinalOne
//
//  Created by Canh Tran on 6/22/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet fileprivate weak var itemImageView: UIImageView!
    @IBOutlet fileprivate weak var itemNameLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Setup display ItemCell
    ///
    /// - Parameter model: Movie model
    func setupMovieCellWithModel(model: Item) {
        
        itemNameLabel.text = model.title
        priceLabel.text = model.price
         
        if let url = URL(string: model.image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            itemImageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: "product_placeholder"),
                                      options: [.transition(ImageTransition.fade(0.2))])
        }
    }
}
