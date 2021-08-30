//
//  ProductInfoCell.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import UIKit
import Cosmos

protocol ProductCellDelegate : class {
    func increaseQuantityClicked(selectedIndex : Int)
    func dcreaseQuantityClicked(selectedIndex : Int)
}

class  ProductInfoCell : UITableViewCell {
    
    //MARK:IbOutlet
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var increseQtyButton: UIButton!
    @IBOutlet weak var decreaseQtyButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    //MARK:Variable
    weak var cellDelegate : ProductCellDelegate?  = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadImageFromUrl(_ product: ProductElement,randomColor : UIColor) {
        productImageView.backgroundColor  = randomColor
        if let url  = URL(string: product.imageURL.optionalValue) {
            DispatchQueue.main.async {
                self.productImageView.sd_setOptimizedImageWithURL(url,imageViewWidth : Int(BAG_CATALOG_PROPOTION * 1.2),pageViewType : PageViewType.Listing)
            }
        }
    }
    
    func setData(product : ProductElement,ishideQtyButton : Bool?,listingVM : ListingViewModel) {
        setUI(primaryColor: listingVM.getPrimaryColor(), priceText: listingVM.gePriceAttributedText(text: product.price.optionalValue), nameText: listingVM.geProductTitleAttributedText(text: product.name.optionalValue))
        ratingView.rating =  listingVM.getRating(rating: product.rating.optionalValue)
        ratingView.isUserInteractionEnabled  = false
        increseQtyButton.isHidden  = listingVM.isHideButton()
        decreaseQtyButton.isHidden  = listingVM.isHideButton()
        quantityLabel.isHidden  = listingVM.isHideButton()
        increseQtyButton.tintColor = listingVM.getPrimaryColor()
    }
    
    func setUI(primaryColor : UIColor,priceText : NSAttributedString,nameText : NSAttributedString) {
        increseQtyButton.tintColor = primaryColor
        decreaseQtyButton.tintColor  = primaryColor
        priceLabel.attributedText  = priceText
        productNameLabel.attributedText = nameText
    }
    
    
    func setData(product : ProductElement,ishideQtyButton : Bool?,cartVM : CartViewModel,isHideRatingView : Bool = false,indexPath : IndexPath,delegate : ProductCellDelegate) {
        self.cellDelegate = delegate
        setUI(primaryColor: cartVM.getPrimaryColor(), priceText: cartVM.gePriceAttributedText(text: product.price.optionalValue), nameText: cartVM.geProductTitleAttributedText(text: product.name.optionalValue))
        quantityLabel.attributedText =  cartVM.getQuantityAttributedText(text: String(product.count))
        increseQtyButton.tag  = indexPath.row
        decreaseQtyButton.tag  = indexPath.row
        ratingView.isHidden  = isHideRatingView ? true : false
    }
    
    
    @IBAction func increaseQuantityAction(_ sender: UIButton) {
        self.cellDelegate?.increaseQuantityClicked(selectedIndex: sender.tag)
    }
    
    @IBAction func decreaseQuantityAction(_ sender: UIButton) {
        self.cellDelegate?.dcreaseQuantityClicked(selectedIndex: sender.tag)
    }
    
}
