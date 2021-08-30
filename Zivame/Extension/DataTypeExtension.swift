//
//  DataTypeExtension.swift
//  Zivame
//
//  Created by Kandavel Umapathy on 16/08/21.
//

import Foundation
extension Array {
    subscript (safe index: NSInteger) -> Element? {
        return Int(index) < count ? self[Int(index)] : nil
}
}
extension Optional where Wrapped == String {
    var optionalValue: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}
extension Optional where Wrapped == Int {
    var optionalValue: Int {
        guard let unwrapped = self else {
            return 0
        }
        return unwrapped
    }
}
extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}
