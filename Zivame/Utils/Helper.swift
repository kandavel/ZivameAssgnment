//
//  Helper.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import UIKit

class Helper {
    class func loadDataFromJSON() -> Product? {
        let url = Bundle.main.url(forResource: "products", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let product = try decoder.decode(Product.self, from: jsonData)
            return product
        } catch {
            return nil
        }
    }
}

