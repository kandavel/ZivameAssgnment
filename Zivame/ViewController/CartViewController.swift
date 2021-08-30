//
//  CartViewController.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 16/08/21.
//

import Foundation
import UIKit
class CartViewController: BaseviewController {
    //MARK:IbOutlet
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var placeOrderButton : UIButton!
    @IBOutlet weak var emptyView : UIView!
    @IBOutlet weak var emptyPlaceHolderLabel: UILabel!
    //MARK:Variable
    let cartVM = CartViewModel()
    weak var dismissDelegate : DismissDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewMethods()
        cartVM.setDelegate(delegate: self)
        setUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func pullToRefreshUI() {
        super.pullToRefreshUI()
    }
    
    func setUI() {
        emptyView.isHidden = true
        self.view.bringSubviewToFront(placeOrderButton)
        emptyPlaceHolderLabel.attributedText  = cartVM.getPlaceHolderLabelText()
        placeOrderButton.backgroundColor = cartVM.getPrimaryColor()
        placeOrderButton.setAttributedTitle(cartVM.getButtonTitleAttaributedtext(), for: .normal)
        placeOrderButton.addTarget(self, action: #selector(openOrderSucessScreen), for: .touchUpInside)
        setRoundedButton()
        addCloseButton()
    }
    
    func addCloseButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissScreen))
        self.navigationItem.leftBarButtonItem?.tintColor =  cartVM.getPrimaryColor()
    }
    
    @objc func dismissScreen() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func openOrderSucessScreen() {
        let vc  = PaymentSucessViewController.openPaymentSuccessScreen(delegate: self)
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    func setRoundedButton()  {
        placeOrderButton.buttonRoundCorners(corners: [.topLeft,.topRight])
    }
    
    func setTableViewMethods() {
        self.tableview.rowHeight = cartVM.getTableViewRowHeight()
        self.tableview.estimatedRowHeight = cartVM.getTableViewEstimatedRowHeight()
        self.tableview.registerCell(cellName: String(describing: ProductInfoCell.self))
        self.tableview.dataSource  = self
        self.tableview.delegate  =  self
        self.tableview.separatorStyle = .none
        self.tableview.reloadData()
    }
}
extension CartViewController : UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartVM.getCartListCount()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let productInfoCell  = cell as? ProductInfoCell {
            if let product  = self.cartVM.getProductInfo(forIndexPath: indexPath) {
                productInfoCell.loadImageFromUrl(product, randomColor: self.cartVM.getRandomColor())
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier  = cartVM.getCellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductInfoCell,let product = cartVM.getProductInfo(forIndexPath: indexPath) {
            cell.setData(product: product, ishideQtyButton: true, cartVM: cartVM,isHideRatingView: cartVM.isShowRating(),indexPath: indexPath,delegate: self)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CartViewController : DismissDelegate {
    func dismissscreen() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    class func openCartViewController() -> CartViewController {
        let viewController  =  UIStoryboard(name: STORYBOARDS.Main, bundle: nil).instantiateViewController(withIdentifier: String(describing: CartViewController.self)) as! CartViewController
        return viewController
    }
}
extension CartViewController : CartVMDelegate {
    func reloadData(isDataEmpty: Bool) {
        let isShow = isDataEmpty ? false : true
        self.emptyView.isHidden  = isShow
        placeOrderButton.isUserInteractionEnabled  = isShow
        placeOrderButton.tintColor  =  cartVM.getDisabledColor()
        self.tableview.isHidden = !(isShow)
        self.tableview.reloadData()
    }
    
    func showalertMessage(_ message: String) {
        self.showAlert(self, message: message)
    }
}

extension CartViewController : ProductCellDelegate {
    func increaseQuantityClicked(selectedIndex: Int) {
        if let product  = self.cartVM.getProductInfo(forIndexPath: IndexPath(row: selectedIndex, section: 0)),let styleId  = product.uniqueId {
            self.cartVM.increaseProductCount(styleId: styleId)
        }
    }
    
    func dcreaseQuantityClicked(selectedIndex: Int) {
        if let product  = self.cartVM.getProductInfo(forIndexPath: IndexPath(row: selectedIndex, section: 0)),let styleId  = product.uniqueId {
            self.cartVM.decreaseProductCount(styleId: styleId)
        }
    }
}
