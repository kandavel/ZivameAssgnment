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
    @IBOutlet weak var loaderView: LottieView!
    //MARK:Variable
    let paymentSuccessVM  = PaymentSuccessVM()
    weak var dismissScreenDelegate : DismissDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func pullToRefreshUI() {
        super.pullToRefreshUI()
    }
    
    func setUI() {
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
