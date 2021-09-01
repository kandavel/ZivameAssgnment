//
//  PaymentSuccessVM.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 28/08/21.
//

import Foundation
import UIKit
class PaymentSuccessVM {
    
    init() {
        
    }
    
    func getCellIdentifier() -> String {
        return String(describing : ProductInfoCell.self)
    }
    
    func getPrimaryColor() -> UIColor {
        return UIColor.Theme.primary_interaction_colour
    }
    
    func gettitle() -> String {
        return "Order Placed"
    }
    
    func deleteDB() {
        PersistantManager.shareInstance.deleteProductsInbag()
    }
    
    
    func getButtonTitleAttaributedtext() -> NSAttributedString {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.Theme.top_nav_text , NSAttributedString.Key.font: UIFont.Avenir.Black.A7]
        return  NSAttributedString(string: "Continue Shopping", attributes: attribute)
    }
    
    func getOrderSuccessMessage() -> NSAttributedString {
        let attribute  = [NSAttributedString.Key.foregroundColor: UIColor.Theme.top_nav_text , NSAttributedString.Key.font: UIFont.Avenir.Black.A7]
        return  NSAttributedString(string: "Order Placed", attributes: attribute)
    }
    
    func getHeaderFont() -> UIFont {
        return UIFont.Avenir.Heavy.A4
    }
    
}
