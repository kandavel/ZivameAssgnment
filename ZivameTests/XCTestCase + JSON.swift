//
//  XCTestCase + JSON.swift
//  ZivameTests
//
//  Created by Kandavel Umapathy on 01/09/21.
//

import Foundation
import UIKit
import XCTest

extension XCTestCase {
    enum TestError: Error {
        case fileNotFound
    }
    
    func getData(fromJSON fileName: String) throws -> Data {
      /*  let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing File: \(fileName).json")
            throw TestError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw error
        }*/
        
        let url = Bundle.main.url(forResource: "products", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            return jsonData
        } catch {
            throw TestError.fileNotFound
        }
        
        
        
    }
}
