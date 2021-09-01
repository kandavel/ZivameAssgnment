//
//  OrderPlacedViewController.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 16/08/21.
//

import Foundation
import UIKit
import Lottie

protocol DismissDelegate : class {
    func dismissscreen()
}

class PaymentSucessViewController: BaseviewController {
    
    //MARK:IbOutlet
    @IBOutlet weak var continueShoppingButton: UIButton!
    @IBOutlet weak var orderPlacedView: UIView!
    @IBOutlet weak var loaderView: UIView!
    //MARK:Variable
    let paymentSuccessVM  = PaymentSuccessVM()
    weak var dismissScreenDelegate : DismissDelegate? = nil
    private var animationView: AnimationView?
    fileprivate var timer: Timer? = nil //Timer used to track keyboard stroke fro n seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAnimation()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTimer()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func pullToRefreshUI() {
        super.pullToRefreshUI()
    }
    
    func setAnimation() {
        self.orderPlacedView.addlottieAnimation(name: "orderPlaced", parentView:  self.orderPlacedView)
        self.orderPlacedView.isHidden = true
        self.loaderView.addlottieAnimation(name: "paymentSuccessful", parentView: self.loaderView)
        loaderView .isHidden = false
      // self.view.bringSubviewToFront(loaderView)
    }
    
    fileprivate func setTimer() {
        weak var weakSelf = self
        weakSelf?.timer?.invalidate()
        weakSelf?.timer = nil
        weakSelf?.timer = Timer.scheduledTimer(timeInterval:  3.0, target: weakSelf ?? self, selector: #selector(showOrderView), userInfo: nil, repeats: false)
    }
    
    @objc func showOrderView() {
        continueShoppingButton.isHidden  = false
        loaderView .isHidden = true
        self.orderPlacedView.isHidden = false
       // self.view.bringSubviewToFront(orderPlacedView)
    }
    
    
    
    func setUI() {
        self.title  =  paymentSuccessVM.gettitle()
        continueShoppingButton.isHidden  = true
        self.view.bringSubviewToFront(continueShoppingButton)
        continueShoppingButton.backgroundColor = paymentSuccessVM.getPrimaryColor()
        continueShoppingButton.setAttributedTitle(paymentSuccessVM.getButtonTitleAttaributedtext(), for: .normal)
        continueShoppingButton.addTarget(self, action: #selector(navigateToListingScreen), for: .touchUpInside)
        setRoundedButton()
        addCloseButton()
    }
    
    func addCloseButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissScreen))
        self.navigationItem.leftBarButtonItem?.tintColor =  paymentSuccessVM.getPrimaryColor()
    }
    
    @objc func dismissScreen() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func navigateToListingScreen() {
        dismissScreen()
        self.paymentSuccessVM.deleteDB()
        self.dismissScreenDelegate?.dismissscreen()
    }
    
    func setRoundedButton()  {
        continueShoppingButton.buttonRoundCorners(corners: [.topLeft,.topRight])
    }
    
}
extension PaymentSucessViewController {
    class func openPaymentSuccessScreen(delegate : DismissDelegate? = nil) -> PaymentSucessViewController {
        let viewController  =  UIStoryboard(name: STORYBOARDS.Main, bundle: nil).instantiateViewController(withIdentifier: String(describing: PaymentSucessViewController.self)) as! PaymentSucessViewController
        viewController.dismissScreenDelegate = delegate
        return viewController
    }
}
