//
//

import Foundation
import BSWFoundation

public enum BrewDogEnvironment: Environment {
    
    case production
    case staging
    case develop
    
    public var baseURL: URL {
        switch self {
        case .production:
            return URL(string: "https://api.punkapi.com/v2/beers")!
        case .staging:
            return URL(string: "https://api.punkapi.com/v2/beers")!
        case .develop:
            return URL(string: "https://api.punkapi.com/v2/beers")!
        }
    }
}
