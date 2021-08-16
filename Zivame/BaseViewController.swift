//
//  BaseViewController.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import UIKit

class BaseviewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUpNavigationStack() {
        
    }
    
    func internetReachableAndRefresh(){
        
    }
    
    func setNavigationBarSettings() {
        if self.navigationBarBackgroundColor == UIColor.clear {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        }
        else if self.navigationBarBackgroundColor ==  UIColor.white{
            if shwNavBarShadow{
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                self.navigationController?.navigationBar.shadowImage = nil
                self.navigationController?.navigationBar.isTranslucent = false
                self.navigationController?.navigationBar.layer.shadowColor = UIColor.Theme.disabledColor.cgColor
                self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                self.navigationController?.navigationBar.layer.shadowRadius = 2.0
                self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
                self.navigationController?.navigationBar.layer.masksToBounds = false
            } else {
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                self.navigationController?.navigationBar.shadowImage = nil
                self.navigationController?.navigationBar.isTranslucent = false
                self.navigationController?.navigationBar.layer.masksToBounds = false
            }
        }else if self.navigationBarBackgroundColor != nil{
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    deinit {
        print("Deallocated")
    }
    
}
