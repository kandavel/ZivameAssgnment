//
//  UIIMageView + Extension.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 16/08/21.
//

import Foundation
import UIKit
import SDWebImage
extension UIImageView {
    func setImageWith(_ url: URL, placeholderImage placeholder: UIImage? = nil,animate : Bool = true) {
        // image url  nil check
        self.sd_setImage(with: url, placeholderImage: placeholder, options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, url) in
            if cacheType == .none{
                self.alpha = 0
                if animate == false{
                    self.alpha = 1
                    self.image = image
                    if error == nil{
                        self.backgroundColor = UIColor.clear
                    }
                } else {
                    UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                        self.alpha = 1
                        self.image = image
                        if error == nil{
                            self.backgroundColor = UIColor.clear
                        }
                    }, completion: { (boolVal) in
                        
                    })
                }
            } else {
                if error == nil{
                    self.backgroundColor = UIColor.clear
                }
            }
        })
    }
    
    @discardableResult func sd_setOptimizedImageWithURL(_ anyImageSizeUrl: URL, placeholderImage placeholder: UIImage? = UIImage(),imageViewWidth : Int,pageViewType : PageViewType? = nil,animate : Bool = true) -> URL?{
        // multiply with current device scale
        let scaledImageViewWidth = imageViewWidth * Int(UIScreen.main.scale)
        let url = ImageSelectionHelper.sharedInstance.getOptimumImageURL(anyImageSizeUrl, imageViewWidth : scaledImageViewWidth,pageViewType: pageViewType) ?? anyImageSizeUrl
        //PassImageUrlInformationToFirebasePerformance
        let backgroundQueue = DispatchQueue.global(qos: .background)
        backgroundQueue.async(execute: {
            self.setImageWith(url,placeholderImage:  placeholder,animate : animate)
        })
        return url
    }
    
}
