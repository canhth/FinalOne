//
//  Products.swift
//  FinalOne
//
//  Created by Canh Tran on 6/21/18.
//  Copyright © 2018 Canh Tran. All rights reserved.
//

import Foundation

struct Products: Decodable {
    var products: Items
}

struct Items: Decodable {
    var items: [Item]
}
