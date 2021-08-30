//
//  UIButton + Extension.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 24/08/21.
//

import Foundation
import UIKit
extension UIButton {
    func buttonRoundCorners(corners: UIRectCorner, radius: CGFloat = 30) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func circularButton(color : UIColor){
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.layer.borderWidth = 0.2
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    func borderButton(color : UIColor){
        self.backgroundColor = .clear
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 1
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        self.layer.borderColor = color.cgColor
    }
}
