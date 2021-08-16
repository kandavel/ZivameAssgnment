//
//  Products.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
class Product: Codable {
    var products: [ProductElement]?

    init(products: [ProductElement]?) {
        self.products = products
    }
}

// MARK: - ProductElement
class ProductElement: Codable {
    var name, price: String?
    var imageURL: String?
    var rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, price
        case imageURL = "image_url"
        case rating
    }

    init(name: String?, price: String?, imageURL: String?, rating: Int?) {
        self.name = name
        self.price = price
        self.imageURL = imageURL
        self.rating = rating
    }
}
class ProductPriceRange {
    var priceRange :  String?
    var productList : [ProductElement] = []
    
    init(priceRange : String,productList : [ProductElement]) {
        self.priceRange  = priceRange
        self.productList  = productList
    }
    
}
