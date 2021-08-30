//
//  ZivameAlertController.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 28/08/21.
//

import Foundation
import UIKit
class ZivameAlertController: UIAlertController {
    
    var isSourceViewSet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isSourceViewSet == false{
            fatalError("Use ZivameAlertController.create() to instantiate alert with Ipad support")
        }
    }
    
    class func create(title: String?, message: String?, preferredStyle: UIAlertController.Style,sourceView:UIView) -> ZivameAlertController {
        let alertController =  ZivameAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.popoverPresentationController?.sourceRect = sourceView.bounds
        alertController.popoverPresentationController?.permittedArrowDirections = [.up , .down]
        alertController.isSourceViewSet = true
        alertController.view.tintColor = UIColor.Theme.primary_interaction_colour
        return alertController
    }
}

extension ZivameAlertController{
    
    /// extension to add actions to alert controller
    /// - Parameter actions: array of valid actions
    func addActions(actions : [UIAlertAction]){
        for action in actions{
            self.addAction(action)
        }
    }
}
