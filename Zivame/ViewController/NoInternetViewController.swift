//
//  NoInternetViewController.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 16/08/21.
//

import Foundation
import UIKit

class NoInternetViewController: BaseviewController {
    
    //MARK:IOutlet
    @IBOutlet weak var noInternetBgView: UIView!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var noInternetConnectionLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func internetReachableAndRefresh() {
        super.internetReachableAndRefresh()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func retryClicked(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
        sharedAppDelegateInstance?.refreshInternetReachability()
    }
    
    class func getNoInternetController() -> NoInternetViewController?{
        let storyboard = UIStoryboard(name: STORYBOARDS.Main, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: NoInternetViewController.self)) as? NoInternetViewController
    }
    
}
