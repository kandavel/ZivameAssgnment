//
//  Constant.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import UIKit

let IS_IPAD = UIDevice().userInterfaceIdiom == UIUserInterfaceIdiom.pad
let SCALE_FACTOR = IS_IPAD ? 1.4 : 1
let emptyString = ""
var sharedAppDelegateInstance = UIApplication.shared.delegate as? AppDelegate
let SCREENWIDTH = CGFloat(UIScreen.main.bounds.width)
let SCREENHEIGHT = CGFloat( UIScreen.main.bounds.height)
let BAG_CATALOG_PROPOTION = CGFloat(SCREENWIDTH * (IS_IPAD ? 0.23 : 0.3))
struct STORYBOARDS {
    static let Main = "Main"
}
struct Notifications {
    static let ReachabilityChanged = "ReachabilityChanged"
}

