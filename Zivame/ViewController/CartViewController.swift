//
//  CartViewController.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 16/08/21.
//

import Foundation
import UIKit
import Lottie

class CartViewController: BaseviewController {
    //MARK:IbOutlet
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var placeOrderButton : UIButton!
    @IBOutlet weak var emptyView : UIView!
    @IBOutlet weak var emptyPlaceHolderLabel: UILabel!
    @IBOutlet weak var lottieView: UIView!
    //MARK:Variable
    let cartVM = CartViewModel()
    private var animationView: AnimationView?
    fileprivate var timer: Timer? = nil //Timer used to track keyboard stroke fro n seconds
    
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
    
    func setUpLottieView() {
        animationView = .init(name: "rocket")
        animationView?.frame  = lottieView.frame
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        lottieView.addSubview(animationView!)
        lottieView .isHidden = true
        animationView!.play()
    }
    
    func setUI() {
        self.title  =  cartVM.getTitle()
        emptyView.isHidden = true
        self.view.bringSubviewToFront(placeOrderButton)
        emptyPlaceHolderLabel.attributedText  = cartVM.getPlaceHolderLabelText()
        placeOrderButton.backgroundColor = cartVM.getPrimaryColor()
        placeOrderButton.setAttributedTitle(cartVM.getButtonTitleAttaributedtext(), for: .normal)
        placeOrderButton.addTarget(self, action: #selector(openOrderSucessScreen), for: .touchUpInside)
        setRoundedButton()
        addCloseButton()
        setUpLottieView()
    }
    
    fileprivate func setTimer() {
        weak var weakSelf = self
        weakSelf?.timer?.invalidate()
        weakSelf?.timer = nil
        weakSelf?.timer = Timer.scheduledTimer(timeInterval:  3.0, target: weakSelf ?? self, selector: #selector(navigateToOrderSuccessScreen), userInfo: nil, repeats: false)
    }
    
    func addCloseButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissScreen))
        self.navigationItem.leftBarButtonItem?.tintColor =  cartVM.getPrimaryColor()
    }
    
    @objc func dismissScreen() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func navigateToOrderSuccessScreen() {
        let vc  = PaymentSucessViewController.openPaymentSuccessScreen(delegate: self)
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc func openOrderSucessScreen() {
        if !(self.cartVM.checkForCartCount()) {
            lottieView.isHidden = false
            self.view.bringSubviewToFront(lottieView)
            setTimer()
        }
        else {
            self.showAlert(self, message: self.cartVM.showAlertMessage())
        }
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
        self.lottieView.isHidden = false
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
