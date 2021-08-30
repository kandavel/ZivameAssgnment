//
//  ListingVIewModel.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import UIKit

protocol ListingViewModelDelegate : class {
    func getPriceRangeList()
    func getUpdatedBagCount()
}

class ListingViewModel {
    
    weak var delegate : ListingViewModelDelegate?
    var productList : [ProductElement] = []
    var product : Product?
    var produtPriceRangeList : [ProductPriceRange] = []
    let minimumPriceRange  = 1000
    
    
    struct Constant {
       static let lowerPriceRangeText  = "PriceRange below Rs.1000"
       static let higherPriceRangeText  = "PriceRange above Rs.1000"
       static let  message  = "Added To Bag"
    }
    
    init() {
        
    }
    
    func prepareData(delegate : ListingViewModelDelegate) {
        self.delegate  = delegate
        loadDataFromJson()
        setProductList()
        sortProducPriceList()
        groupPriceRangeList()
        self.delegate?.getPriceRangeList()
    }
    
    func getPrimaryColor() ->  UIColor {
        return UIColor.Theme.primary_interaction_colour
    }
    
    func getRandomColor() -> UIColor {
        return UIColor.Theme.randomColorArray[Int(arc4random()%5)]
    }
    
    func getCellIdentifier() -> String {
        return String(describing : ProductInfoCell.self)
    }
    
    func getHeaderFont() -> UIFont {
        return UIFont.Avenir.Heavy.A4
    }
    
    func getHeaderSize() -> CGFloat {
        return 44.0
    }
    
    func isHideButton() -> Bool {
        return true
    }
    
    /// Get TableView row section height
    func getTableViewRowHeight() -> CGFloat{
        return UITableView.automaticDimension
    }
    
    /// Get Tableview estimated row height
    func getTableViewEstimatedRowHeight() -> CGFloat {
        return 150.0
    }
    
    /// Get Tableview estimated section header height
    func getTableViewEstimatedSectionHeaderHeight() -> CGFloat {
        return 44.0
    }
    
    func setProductList() {
        self.productList = self.product?.products.map({ (productElementList) -> [ProductElement] in
            let list =  productElementList.enumerated().map { (index,productElement) -> ProductElement in
                productElement.uniqueId  =  String(index + 1)
                return productElement
            }
            return list
        }) ?? []
    }
    
    func genrateUniqueId(length: Int) -> String {
        let letters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        var randomString: String = ""
        for _ in 0..<length {
            let randomNumber = Int.random(in: 0..<letters.count)
            randomString.append(letters[randomNumber])
        }
        return randomString
    }
    
    func loadDataFromJson() {
        self.product  = Helper.loadDataFromJSON()
    }
    
    func sortProducPriceList() {
        self.productList = self.sortArrayList(list: self.product?.products ?? [])
    }
    
    func groupPriceRangeList() {
        self.produtPriceRangeList  = groupProductListIntoPriceRange(list :self.productList)
    }
    
    func getTableViewSectionCount() -> Int {
        return produtPriceRangeList.count
    }
    
    func getRowCount(forSection section : Int) -> Int {
        return produtPriceRangeList[section].productList.count
    }
    
    func groupProductListIntoPriceRange(list : [ProductElement]) -> [ProductPriceRange] {
        var productPriceRangeList  : [ProductPriceRange] = []
        let minimumPriceRange = ProductPriceRange(priceRange: Constant.lowerPriceRangeText, productList: [])
        let maximumPriceRange = ProductPriceRange(priceRange: Constant.higherPriceRangeText, productList: [])
        for eachProduct in list {
            let price =  Int(eachProduct.price ?? "0") ?? 0
            if price <= self.minimumPriceRange {
                minimumPriceRange.productList.append(eachProduct)
            }
            else {
                maximumPriceRange.productList.append(eachProduct)
            }
        }
        productPriceRangeList.append(minimumPriceRange)
        productPriceRangeList.append(maximumPriceRange)
        return productPriceRangeList
    }
    
    func sortArrayList(list : [ProductElement])  -> [ProductElement] {
        return list.sorted { (productElement1, productElement2) -> Bool in
            Int(productElement1.price ?? "0") ?? 0 < Int(productElement2.price ?? "0") ?? 0
        }
    }
    
    func getPriceRangeInfo() -> String? {
        return nil
    }
    
    
    func getBagCount() -> Int {
        return PersistantManager.shareInstance.getBagCount() ?? 0
    }
    
    func addProductToBag(indexPath : IndexPath) {
        if let product = getProductInfo(forSection: indexPath) {
            PersistantManager.shareInstance.addItemToDB(product: product)
        }
    }
    
    
    func getProductInfo(forSection  indexPath : IndexPath) -> ProductElement? {
        if let product  = self.produtPriceRangeList[safe : indexPath.section]?.productList[safe : indexPath.row] {
            return product
        }
        return nil
    }
    
    func getRating(rating : Int) -> Double {
        return Double(rating) 
    }
    
    func getSectionTitle(forSection section : Int) -> NSAttributedString? {
        if let title  = self.produtPriceRangeList[safe : section]?.priceRange {
            let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont.Avenir.Heavy.A4]
            return  NSAttributedString(string: title, attributes: attribute)
        }
        return nil
    }
    
    func geProductTitleAttributedText(text : String) -> NSAttributedString {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont.Avenir.Black.A3]
        return  NSAttributedString(string: text, attributes: attribute)
    }
    
    func gePriceAttributedText(text : String) -> NSAttributedString {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont.Avenir.Medium.A2]
        return  NSAttributedString(string: "Rs.\(text)", attributes: attribute)
    }
    
}
