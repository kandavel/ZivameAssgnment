//
//  PersistantTest.swift
//  ZivameTests
//
//  Created by Kandavel Umapathy on 01/09/21.
//

import Foundation
import XCTest
import CoreData
@testable import Zivame

class PersistantTest: XCTestCase {
    
    var persistantManager : PersistantManager!
    
    override func setUpWithError() throws {
        super.setUp()
        persistantManager = PersistantManager.shareInstance
    }
    
    

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testAddObjectInDB() {
        let productElement1  = ProductElement(name: "OnePlus 6 (Mirror Black 6GB RAM + 64GB memory)", price: "34999", imageURL: "https://images-eu.ssl-images-amazon.com/images/I/41DZ309iN9L._AC_US160_.jpg", rating: 4)
        productElement1.uniqueId  = "1"
        let productElement2  = ProductElement(name: "Nokia 105 (Black)", price: "999", imageURL: "https://images-eu.ssl-images-amazon.com/images/I/41gYdatbC4L._AC_US160_.jpg", rating: 4)
        productElement2.uniqueId  = "2"
        let productElement3  = ProductElement(name: "Samsung On7 Pro (Gold)", price: "7990", imageURL: "https://images-eu.ssl-images-amazon.com/images/I/41INpKtZV-L._AC_US160_.jpg", rating: 3)
        productElement3.uniqueId  = "3"
        
        persistantManager.addItemToDB(product: productElement1)
        persistantManager.addItemToDB(product: productElement2)
        persistantManager.addItemToDB(product: productElement3)
        _ = self.expectation(description: "Inserting Object Expectation")
        if let productInfoList  = self.persistantManager.getProductInfoList() {
            XCTAssertEqual(productInfoList.count, 3)
            XCTAssertEqual(self.persistantManager.getBagCount(),3)
            XCTAssertNotNil(productInfoList.first?.id)
        }
        else {
            XCTFail("No data is stored is DB")
        }
    }
    
    
    
    func testDeleteAllObjectInDB() {
        _ = self.expectation(description: "Remove all object expectation")
        persistantManager.deleteProductsInbag()
        if self.persistantManager.getProductInfoList() != nil {
            XCTFail("data is removed in DB :: Some data is still persisting")
        }
        else {
            XCTAssertTrue(true)
        }
    }
    
    func testUpdateObjectInDB() {
        
    }
    


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
