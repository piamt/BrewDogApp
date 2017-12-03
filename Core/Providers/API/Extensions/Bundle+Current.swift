//
//  Bundle+Current.swift
//  Pods
//

import Foundation

class BundleDummyTracker {}

extension Bundle {
    
    class var current: Bundle {
        guard let bundleURL = Bundle(for: BundleDummyTracker.self).url(forResource: "BrewDogCoreBundle", withExtension: "bundle") else {
            return Bundle.main
        }
        return Bundle(url: bundleURL)!
    }
    
    class func jsonData(named: String) -> Data? {
        guard let existingURL = current.url(forResource: named, withExtension: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: existingURL)
    }
}
