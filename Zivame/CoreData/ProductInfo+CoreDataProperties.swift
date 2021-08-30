//
//  ProductInfo+CoreDataProperties.swift
//  
//
//  Created by Kandavel Umapathy on 18/08/21.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ProductInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductInfo> {
        return NSFetchRequest<ProductInfo>(entityName: "ProductInfo")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var quantity: Int32
    @NSManaged public var rating: String?
    @NSManaged public var date:Date?

}

extension ProductInfo : Identifiable {

}
