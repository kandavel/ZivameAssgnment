//
//  ZivameTests.swift
//  ZivameTests
//
//  Created by Kandavel Umapathy on 13/08/21.
//

import XCTest
@testable import Zivame
@testable import Zivame

class ZivameTests: XCTestCase {
    
    var productresponse : Product!
    var productList : [ProductElement]!
    var productPriceRangeList : [ProductPriceRange]!
    var listingVM  = ListingViewModel()

    override func setUpWithError() throws {
        super.setUp()
        let data = try getData(fromJSON: "products")
        productresponse = try JSONDecoder().decode(Product.self, from: data)
        productList = productresponse.products
        productList =  listingVM.sortArrayList(list: productList)
        productPriceRangeList =  listingVM.groupProductListIntoPriceRange(list: productList)
    }
    
    

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        productList =  nil
    }
    
    func testListCount() throws {
        print(productList.isEmpty)
        
        XCTAssertTrue(!(productList.isEmpty), "List is not empty")
    }

    func testSortIsHappened()  throws {
        let first  = Int(self.productList.first?.uniqueId ?? "0")!
        let last   = Int(self.productList.last?.uniqueId ?? "0")!
         XCTAssertLessThan(first,last)
    }
    
    func testProductPriceRangeList() throws {
        let priceRangeMinimum  = productPriceRangeList.first?.priceRange!
        let priceRangeMaximum  = productPriceRangeList.last?.priceRange!
        XCTAssertEqual(priceRangeMinimum == "PriceRange below Rs.1000", priceRangeMaximum == "PriceRange above Rs.1000")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
