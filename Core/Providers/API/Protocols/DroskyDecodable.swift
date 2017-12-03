//
//  Droskyable.swift
//  Pods
//
//

import BSWFoundation
import Deferred

protocol DroskyDecodable : Decodable {
    static func fromDroskyResponse(_ droskyResponse: DroskyResponse) -> Task<Self>
}

extension DroskyDecodable {
    
    static func fromDroskyResponse(_ droskyResponse: DroskyResponse) -> Task<Self> {
        
        switch droskyResponse.statusCode {
        case 200:
            return JSONParser.parseDataAsync(droskyResponse.data)
        case 400:
            return Task(failure: BrewDogErrors.badRequest)
        default:
            let errorMessage = JSONParser.errorMessageFromData(droskyResponse.data)
            return Task(failure: BrewDogErrors.unknownError(errorMessage))
        }
    }
}

extension Collection where Iterator.Element : DroskyDecodable {
    static func fromDroskyResponse(_ droskyResponse: DroskyResponse) -> Task<[Iterator.Element]> {
        
        switch droskyResponse.statusCode {
        case 200:
            return JSONParser.parseDataAsync(droskyResponse.data)
        case 400:
            return Task(failure: BrewDogErrors.badRequest)
        default:
            let errorMessage = JSONParser.errorMessageFromData(droskyResponse.data)
            return Task(failure: BrewDogErrors.unknownError(errorMessage))
        }
    }
}
