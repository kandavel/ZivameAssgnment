//
//  UIView + Extension.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import UIKit
extension UIView {
    
    func addConstraintWithSuperView(_ toSuperView : UIView,leadingSpace : CGFloat,trailingSpace : CGFloat,topSpace : CGFloat,bottomSpace : CGFloat){
        let leadingConstraint =  NSLayoutConstraint(item: self, attribute:
                                                        .leading, relatedBy: .equal, toItem: toSuperView,
                                                    attribute: .leading, multiplier: 1.0,
                                                    constant: leadingSpace)
        let trailingConstraint =  NSLayoutConstraint(item: self, attribute:
                                                        .trailing , relatedBy: .equal, toItem: toSuperView,
                                                     attribute: .trailing, multiplier: 1.0,
                                                     constant: -trailingSpace)
        let TopMarginConstraint =  NSLayoutConstraint(item: self, attribute:
                                                        .top, relatedBy: .equal, toItem: toSuperView,
                                                      attribute: .top, multiplier: 1.0,
                                                      constant: topSpace)
        let BottomMarginConstraint =  NSLayoutConstraint(item: self, attribute:
                                                            .bottom, relatedBy: .equal, toItem: toSuperView,
                                                         attribute: .bottom, multiplier: 1.0,
                                                         constant: bottomSpace)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leadingConstraint,trailingConstraint,TopMarginConstraint,BottomMarginConstraint])
    }
    
    func centerToSuperView(_ toSuperView : UIView,x:CGFloat = 0,y: CGFloat = 0){
        let centerXConstraint =  NSLayoutConstraint(item: self, attribute:
                                                        .centerX, relatedBy: .equal, toItem: toSuperView,
                                                    attribute: .centerX, multiplier: 1.0,
                                                    constant: x)
        let centerYConstraint =  NSLayoutConstraint(item: self, attribute:
                                                        .centerY , relatedBy: .equal, toItem: toSuperView,
                                                    attribute: .centerY, multiplier: 1.0,
                                                    constant: y)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
    }
    
    func showLoader(_ activityIndicatorStyle: UIActivityIndicatorView.Style = IS_IPAD ? .whiteLarge : .gray,onTopOf : UIView? = nil,color : UIColor? = UIColor.Theme.primary_interaction_colour,withYOffest : CGFloat = 0){
        var frameView = self
        if let onTopOf = onTopOf{
            frameView = onTopOf
            
        }
        if self.viewWithTag(12345) == nil{
            //Make sure multiple activityIndicators are not added to the same view
            self.isUserInteractionEnabled = false
            let activityIndicator = UIActivityIndicatorView(style: activityIndicatorStyle)
            activityIndicator.tag = 12345
            activityIndicator.frame = CGRect(x: frameView.frame.origin.x + frameView.frame.size.width/2 - 13,y: frameView.frame.origin.y +  frameView.frame.size.height/2 - 13 + withYOffest, width: 26, height: 26)
            self.addSubview(activityIndicator)
            activityIndicator.color = color
            activityIndicator.startAnimating()
        }
    }
    
    func dismissloader(){
        self.isUserInteractionEnabled = true
        if let  activityIndicator = self.viewWithTag(12345) as? UIActivityIndicatorView{
            activityIndicator.removeFromSuperview()
        }
    }
    
}
