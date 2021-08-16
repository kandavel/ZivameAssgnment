//
//  ListingVIewModel.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation

protocol ListingViewModelDelegate : class {
    func getPriceRangeList()
}

class ListingViewModel {
    
    var productList : [ProductElement] = []
    var produtPriceRangeList : [ProductPriceRange] = []
    
    init() {
        
    }
    
    func getProductListInfo() {
        
    }
    
    func loadDataFromJson() {
        
    }
    
    func sortProducPriceList() {
        
    }
    
    func groupPriceRangeList() {
        
    }
    
    func getPriceRangeInfo() -> String? {
        
        return nil
    }
    
    func getProductInfo(forSection section : IndexPath) -> ProductElement? {
        
        return nil
    }
    
}
