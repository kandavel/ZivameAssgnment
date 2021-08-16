//
//  Font.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 14/08/21.
//

import Foundation
import UIKit
extension UIFont{
    
    public struct Avenir {
        
        struct Medium {
            static let A0 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:11.0))!
            static let A1 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:12.0))!
            static let A2 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:13.0))!
            static let A3 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:14.0))!
            static let A4 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:15.0))!
            static let A5 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:16.0))!
            static let A6 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:18.0))!
            static let A7 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:22.0))!
            static let A8 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:24.0))!
            static let A9 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:17.0))!
            static let A10 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:19.0))!
            static let A11 = UIFont(name: "Avenir-medium", size: getFontSizeFor(baseSize:27.0))!
        }
        
        struct Black {
            static let A0 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:11.0))!
            static let A1 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:12.0))!
            static let A2 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:13.0))!
            static let A3 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:14.0))!
            static let A4 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:15.0))!
            static let A6 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:16.0))!
            static let A7 = UIFont(name: "Avenir-black", size: getFontSizeFor(baseSize: 20.0))!
            static let A8 = UIFont(name: "Avenir-black", size: getFontSizeFor(baseSize: 24.0))!
            static let A9 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize: 30.0))!
            static let A10 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:19.0))!
            static let A11 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:36.0))!
            static let A12 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:32.0))!
            static let A13 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:17.0))!
            static let A14 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:18.0))!
            static let A15 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:37.0))!
            static let A16 = UIFont(name: "Avenir-Black", size: getFontSizeFor(baseSize:25.0))!
        }
        
        struct Book {
            static let A0 = UIFont(name: "Avenir-book", size: getFontSizeFor(baseSize:11.0))!
            static let A1 = UIFont(name: "Avenir-book", size: getFontSizeFor(baseSize:12.0))!
            static let A2 = UIFont(name: "Avenir-book", size: getFontSizeFor(baseSize:13.0))!
            static let A3 = UIFont(name: "Avenir-book", size: getFontSizeFor(baseSize:14.0))!
            static let A4 = UIFont(name: "Avenir-book", size: getFontSizeFor(baseSize:15.0))!
            static let A6 = UIFont(name: "Avenir-book", size: getFontSizeFor(baseSize:16.0))!
            static let A7 = UIFont(name: "Avenir-book", size: getFontSizeFor(baseSize:17.0))!
        }
        
        struct Heavy {
            static let A0 = UIFont(name: "Avenir-Heavy", size: getFontSizeFor(baseSize:11.0))!
            static let A1 = UIFont(name: "Avenir-Heavy", size: getFontSizeFor(baseSize:12.0))!
            static let A2 = UIFont(name: "Avenir-Heavy", size: getFontSizeFor(baseSize:13.0))!
            static let A3 = UIFont(name: "Avenir-Heavy", size: getFontSizeFor(baseSize:14.0))!
            static let A4 = UIFont(name: "Avenir-Heavy", size: getFontSizeFor(baseSize:15.0))!
            static let A6 = UIFont(name: "Avenir-Heavy", size: getFontSizeFor(baseSize:16.0))!
            static let A7 = UIFont(name: "Avenir-Heavy", size: getFontSizeFor(baseSize:19.0))!
        }
        
        struct Roman {
            static let A0 = UIFont(name: "Avenir-Roman", size: getFontSizeFor(baseSize:11.0))!
            static let A1 = UIFont(name: "Avenir-Roman", size: getFontSizeFor(baseSize:12.0))!
            static let A2 = UIFont(name: "Avenir-Roman", size: getFontSizeFor(baseSize:13.0))!
            static let A3 = UIFont(name: "Avenir-Roman", size: getFontSizeFor(baseSize:14.0))!
            static let A4 = UIFont(name: "Avenir-Roman", size: getFontSizeFor(baseSize:15.0))!
            static let A5 = UIFont(name: "Avenir-Roman", size: getFontSizeFor(baseSize:16.0))!
        }
    }
    
    struct AvenirLTStd {
        struct Book {
            static let A0 = UIFont(name: "AvenirLTStd-Book", size: getFontSizeFor(baseSize:11.0))!
            static let A1 = UIFont(name: "AvenirLTStd-Book", size: getFontSizeFor(baseSize:12.0))!
            static let A2 = UIFont(name: "AvenirLTStd-Book", size: getFontSizeFor(baseSize:13.0))!
            static let A3 = UIFont(name: "AvenirLTStd-Book", size: getFontSizeFor(baseSize:14.0))!
            static let A4 = UIFont(name: "AvenirLTStd-Book", size: getFontSizeFor(baseSize:15.0))!
            static let A6 = UIFont(name: "AvenirLTStd-Book", size: getFontSizeFor(baseSize:16.0))!
        }
    }
}
func getFontSizeFor(baseSize : CGFloat) -> CGFloat{
    
    var sizeForIPAD = baseSize
    if IS_IPAD{
        switch baseSize {
        case 10: sizeForIPAD = 13; break;
        case 11: sizeForIPAD = 14; break;
        case 12: sizeForIPAD = 15; break;
        case 13: sizeForIPAD = 16; break;
        case 14: sizeForIPAD = 17; break;
        case 15: sizeForIPAD = 18; break;
        case 16: sizeForIPAD = 19; break;
        case 17: sizeForIPAD = 20; break;
        case 18: sizeForIPAD = 22; break;
        case 19: sizeForIPAD = 24; break;
        case 24: sizeForIPAD = 32; break;
        case 32: sizeForIPAD = 34; break;
        case 25: sizeForIPAD = 41; break;
        case 36: sizeForIPAD = 44; break;
            
        default:
            sizeForIPAD = baseSize * CGFloat(SCALE_FACTOR)
        }
    }
    
    return sizeForIPAD
    
}
