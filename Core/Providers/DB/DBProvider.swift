//
//  DBProvider.swift
//  Alamofire
//
//  Created by Pia on 30/11/2017.
//

import Foundation
import RealmSwift
import Deferred

enum DBErrors: Error {
    case unableToWrite
}

public protocol DBProviderType {
    func write(beer: BeerModelRealm, food: String) -> Task<()>
    func read(food: String) -> [BeerModelRealm]?
}

public class DBProvider: DBProviderType {
    
    var realm: Realm
    
    public init?() {
        guard let realm = try? Realm() else {
            return nil
        }
        self.realm = realm
    }
    
    public func write(beer: BeerModelRealm, food: String) -> Task<()> {
        let deferred = Deferred<Task<()>.Result>()
        
        do {
            if let model = search(id: beer.id) {
                try realm.write {
                    let type = getType()
                    type.text = food
                    model.food_pairing_searched.append(type)
                    deferred.fill(with: .success(()))
                }
            } else {
                try realm.write {
                    _ = realm.add(beer)
                }
                deferred.fill(with: .success(()))
            }
        } catch {
            deferred.fill(with: .failure(RepositoryError.cantSave))
        }
        
        return Task(future: Future(deferred))
    }
    
    public func read(food: String) -> [BeerModelRealm]? {
        let predicate = NSPredicate(format: "ANY food_pairing_searched.text == %@", food)
        let results = realm.objects(BeerModelRealm.self).filter(predicate)
        var beers = [BeerModelRealm]()
        results.forEach({ (beer) in
            beers.append(beer)
        })
        
        beers.forEach { (beer) in
            print("id: \(beer.id), foods: \(beer.food_pairing_searched)")
        }
        return beers
    }
    
    public func search(id: Double) -> BeerModelRealm? {
        let predicate = NSPredicate(format: "id == %f", id)
        let results = realm.objects(BeerModelRealm.self).filter(predicate)
        var beers = [BeerModelRealm]()
        results.forEach({ (beer) in
            beers.append(beer)
        })
        return beers.first
    }
    
    func clearAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
