//
//

import BSWFoundation

enum BrewDogEndpoint {
    case beers(food: String)
}

extension BrewDogEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .beers(let food):
            return "?food=\(food)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .beers:
                return .GET
        }
    }
    
    var parameters: [String : AnyObject]? {
        switch self {
        case .beers:
            return nil
        }
    }
    
    var httpHeaderFields: [String : String]? {
        switch self {
        case .beers:
            guard let token = AuthSimpleStorage.defaultStorage.token() else {
                return nil
            }
            return ["Authorization" : "Token \(token)"]
        }
    }
    
    var parameterEncoding: HTTPParameterEncoding {
        return .url
    }
}

public enum BrewDogErrors: Error {
    case badRequest
    case malformedResponse
    case unknownError(String?)
}
