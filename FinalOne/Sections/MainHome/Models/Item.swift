//
//  Item.swift
//  FinalOne
//
//  Created by Canh Tran on 6/21/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import Foundation

struct Item: Decodable {
    var title: String = ""
    var price: String = ""
    var image: String = ""
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
        case title = "title"
        case price = "price"
        case image = "image"
    }
    
    /// Decoding
    init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        let items       = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .items)
        title           = try items.decode(String.self, forKey: .title)
        price           = try items.decode(String.self, forKey: .price)
        image           = try items.decode(String.self, forKey: .image)
    }
    
    /// Encoding
    func encode(to encoder: Encoder) throws {
        var container   = encoder.container(keyedBy: CodingKeys.self)
        var items       = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .items)
        try items.encode(title, forKey: .title)
        try items.encode(price, forKey: .price)
        try items.encode(image, forKey: .image)
    }
}
