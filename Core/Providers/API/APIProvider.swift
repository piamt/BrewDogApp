//
//

import BSWFoundation
import Deferred

public enum CurrentEnvironment {
    static public let environment: BrewDogEnvironment = .staging
}

public protocol APIProviderType {
    func retrieveBeerList(food: String) -> Task<[BeerResponse]>
}

public class APIProvider {

    fileprivate let drosky = Drosky(environment: CurrentEnvironment.environment)
    static let queue = queueForSubmodule("APIClient")
    
    private init() {}
    
    public static let `default` = APIProvider()
    
    public func setToken(_ token: String) {
        drosky.setAuthSignature(("Authorization", "Token \(token)"))
    }
}

extension APIProvider: APIProviderType {
    
    public func retrieveBeerList(food: String) -> Task<[BeerResponse]> {
        
        return drosky.performRequest(forEndpoint:
            BrewDogEndpoint.beers(food: food))
            ≈> [BeerResponse].fromDroskyResponse
    }
    
    public func fromDroskyResponse(droskyResponse: DroskyResponse) -> Task<()> {
        let deferred = Deferred<Task<()>.Result>()
        
        APIProvider.queue.addOperation {
            switch droskyResponse.statusCode {
            case 200...299:
                deferred.fill(with: .success(()))
            case 400:
                deferred.fill(with: .failure(BrewDogErrors.badRequest))
            default:
                let errorMessage = JSONParser.errorMessageFromData(droskyResponse.data)
                deferred.fill(with: .failure(BrewDogErrors.unknownError(errorMessage)))
            }
        }
        
        return Task(future: Future(deferred))
    }
}

//TODO: Move this to test
public class APIProviderFake: APIProviderType {
    
    public func retrieveBeerList(food: String) -> Task<[BeerResponse]> {
        let data = Data(contentsOfJSONFile: "BeerList", bundle: Bundle.current)
        return JSONParser.parseDataAsync(data)
    }
}
