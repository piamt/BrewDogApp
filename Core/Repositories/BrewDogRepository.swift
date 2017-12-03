//
//

import Foundation
import Deferred
import BSWFoundation

enum RepositoryError: Error {
    case noData
    case cantSave
}

public protocol BrewDogRepositoryType {
    func retrieveBeerList(food: String) -> Task<[BeerResponse]>
}

public class BrewDogRepository {
    
    let apiProvider: APIProviderType
    let dbProvider: DBProviderType?
    
    public static let `default`: BrewDogRepositoryType = BrewDogRepository()
    
    public init(apiProvider: APIProviderType = APIProvider.default,
                dbProvider: DBProviderType? = DBProvider()) {
        self.apiProvider = apiProvider
        self.dbProvider = dbProvider
    }
}

extension BrewDogRepository: BrewDogRepositoryType {
    
    public func retrieveBeerList(food: String) -> Task<[BeerResponse]> {
        
        let task = retrieveBeerDBList(food: food)
        return task.andThen(upon: .global(), start: { (list) -> Task<[BeerResponse]> in
            guard list.count > 0 else {
                
                let task = self.apiProvider.retrieveBeerList(food: food).andThen(upon: .main, start: { (list) -> Task<[BeerResponse]> in
                    list.forEach({ (response) in
                        var resp: BeerResponse = response
                        resp.food_pairing_searched.append(food)
                        _ = self.dbProvider?.write(beer: resp.toRealmModel, food: food)
                    })
                    return Task(success: list)
                })
                
                return task
            }
            
            return Task(success: list)
        })
    }

    public func retrieveBeerDBList(food: String) -> Task<[BeerResponse]> {
        
        guard let dbProvider = dbProvider,
            let technologies = dbProvider.read(food: food) else {
                return Task(success: [])
        }
        
        var techList = [BeerResponse]()
        
        technologies.forEach({ (tech) in
            techList.append(tech.toModel)
        })
        
        return Task(success: techList)
    }
}
