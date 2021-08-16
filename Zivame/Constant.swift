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


