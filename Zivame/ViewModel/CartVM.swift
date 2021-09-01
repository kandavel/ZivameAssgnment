//
//  CartVM.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 21/08/21.
//

import Foundation
import UIKit

protocol CartVMDelegate : class {
    func showalertMessage(_ message : String)
    func reloadData(isDataEmpty : Bool)
}

class CartViewModel {
    
    init() {
        
    }
    
    weak var cartVMDelegate : CartVMDelegate? = nil
    
    func setDelegate(delegate :CartVMDelegate) {
        self.cartVMDelegate =  delegate
        self.cartlist =  self.getCartListItemsFromDB() ?? []
        self.cartVMDelegate?.reloadData(isDataEmpty: checkFoDataCount())
    }
    
    var cartlist  : [ProductElement] = []
    
    
    func getTitle() -> String {
        return "Kandavel's Bag"
    }
    
    func showAlertMessage() -> String {
        return "Please add items to bag"
    }
    
    func getCellIdentifier() -> String {
        return String(describing : ProductInfoCell.self)
    }
    
    func getPrimaryColor() -> UIColor {
        return UIColor.Theme.primary_interaction_colour
    }
    
    func getRandomColor() -> UIColor {
        return UIColor.Theme.randomColorArray[Int(arc4random()%5)]
    }
    
    func getDisabledColor() -> UIColor {
        return UIColor.Theme.disabledColor
    }
    
    
    func getButtonTitleAttaributedtext() -> NSAttributedString {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.Theme.top_nav_text , NSAttributedString.Key.font: UIFont.Avenir.Black.A7]
        return  NSAttributedString(string: "Place Order", attributes: attribute)
    }
    
    func getPlaceHolderLabelText() -> NSAttributedString {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont.Avenir.Medium.A7]
        return  NSAttributedString(string: "That’s one really empty bag...", attributes: attribute)
    }
    
    
    func getHeaderFont() -> UIFont {
        return UIFont.Avenir.Heavy.A4
    }
    
    func getHeaderSize() -> CGFloat {
        return 44.0
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
    
    
    func getCartListCount() -> Int {
        return cartlist.count
    }
    
    func checkForCartCount() -> Bool {
        return getCartListCount() == 0 ? true : false
    }
    
    
    fileprivate func getProductFromDB(styleId : String) -> ProductInfo? {
        let productInfo  =  PersistantManager.shareInstance.getProductInfo(styleId: styleId)
        return productInfo
    }
    
    func checkForProductCount(styleId : String) -> Int? {
        if let prodcutInfo =  getProductFromDB(styleId: styleId) {
            let count = Int(prodcutInfo.quantity)
            return count
        }
        return nil
    }
    
    func increaseProductCount(styleId : String) {
        let productCount  = self.cartlist.filter {$0.uniqueId == styleId}.first?.count ?? 0
        if let count = checkForProductCount(styleId: styleId) {
            if count >= 1 && productCount < 5 {
                if let product =  getProductfromStyleId(styleId: styleId) {
                    PersistantManager.shareInstance.addItemToDB(product: product)
                }
            }
            else {
                self.cartVMDelegate?.showalertMessage("Sorry!,Maximum Limit is 4 quantity per product")
            }
        }
        else {
            self.cartVMDelegate?.showalertMessage("Unablet to add")
        }
        refereshData()
    }
    
    func getProductfromStyleId(styleId : String) -> ProductElement? {
        return self.cartlist.filter{$0.uniqueId == styleId}.first
    }
    
    func decreaseProductCount(styleId : String) {
        if let count = checkForProductCount(styleId: styleId) {
            if count >= 1  {
                if let product =  getProductfromStyleId(styleId: styleId) {
                    PersistantManager.shareInstance.addItemToDB(product: product,isDecdreasequantity: true)
                }
            }
            else {
                PersistantManager.shareInstance.deleteProductFromDB(styleId: styleId)
            }
        }
        refereshData()
    }
    
    
    func refereshData() {
        self.cartlist =  self.getCartListItemsFromDB() ?? []
        self.cartVMDelegate?.reloadData(isDataEmpty: checkFoDataCount())
    }
    
    func checkFoDataCount() -> Bool {
        return self.cartlist.isEmpty ? true : false
    }
    
    
    fileprivate func convertDBModelToProductElement(_ productInfo: ProductInfo) -> ProductElement {
        let price  =  productInfo.price?.description ?? emptyString
        let productElement  = ProductElement(name: productInfo.name, price: price, imageURL: productInfo.imageUrl, rating: Int(productInfo.rating ?? "0"))
        productElement.uniqueId  = productInfo.id
        productElement.count  = Int(productInfo.quantity)
        return productElement
    }
    
    func getCartListItemsFromDB() -> [ProductElement]? {
        if let productInfoList  = PersistantManager.shareInstance.getProductInfoList() {
            let cartlist = productInfoList.map({ (productInfo) -> ProductElement in
                return convertDBModelToProductElement(productInfo)
            })
            return cartlist
        }
        return nil
    }
    
    func isShowRating() -> Bool {
        return true
    }
    
    func getProductInfo(forIndexPath indexpath : IndexPath) -> ProductElement? {
        let product  = self.cartlist[indexpath.row]
        return product
    }
    
    func getRating(rating : Int) -> Double {
        return Double(rating)
    }
    
    func getQuantityAttributedText(text : String)  -> NSAttributedString  {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont.Avenir.Book.A3]
        return  NSAttributedString(string: text, attributes: attribute)
    }
    
    func geProductTitleAttributedText(text : String) -> NSAttributedString {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont.Avenir.Black.A3]
        return  NSAttributedString(string: text, attributes: attribute)
    }
    
    func gePriceAttributedText(text : String) -> NSAttributedString {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.black , NSAttributedString.Key.font: UIFont.Avenir.Medium.A2]
        return  NSAttributedString(string: "Rs.\(text)", attributes: attribute)
    }
    
    func checkForMaximumCountReached() -> Bool {
        return true
    }
    
}
