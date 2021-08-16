//
//  ProductInfoCell.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import UIKit
import Cosmos

class  ProductInfoCell : UITableViewCell {
    
    //MARK:IbOutlet
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var increseQtyButton: UIButton!
    @IBOutlet weak var decreaseQtyButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(imageUrl : String?) {
        
    }
    
}
