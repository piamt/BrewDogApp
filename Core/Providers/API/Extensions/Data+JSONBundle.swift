//
//  Data+JSONBundle.swift
//

import Foundation

extension Data {
    
    public init(contentsOfJSONFile file: String, bundle: Bundle) {
        guard let path = bundle.path(forResource: file, ofType: "json"),
            let jsonStr = try? String(contentsOfFile: path),
            let data = jsonStr.data(using: .utf8, allowLossyConversion: false) else {
                fatalError()
        }
        
        self = data
    }
}
