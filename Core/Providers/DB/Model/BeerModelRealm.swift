//
//  BeerModelRealm.swift
//  Alamofire
//
//  Created by Pia on 30/11/2017.
//

import Foundation
import RealmSwift

public class BeerModelRealm: Object {
    @objc dynamic var id = 0.0
    @objc dynamic var name = ""
    @objc dynamic var tagline = ""
    @objc dynamic var abv = 0.0
    @objc dynamic var desc = ""
    @objc dynamic var imageURL = ""
    var food_pairing_searched: List<getType> = List()
}

class getType: Object {
    @objc dynamic var text: String = ""
}

extension BeerModelRealm {
    var toModel: BeerResponse {
        
        var list = [String]()
        for food in self.food_pairing_searched {
            list.append(food.text)
        }

        return BeerResponse(id: self.id, name: self.name, tagline: self.tagline, abv: self.abv, description: self.desc, image_url: self.imageURL, food_pairing_searched: list)
    }
}

extension BeerResponse {
    var toRealmModel: BeerModelRealm {
        let beerRealm = BeerModelRealm()
        beerRealm.id = self.id
        beerRealm.name = self.name
        beerRealm.tagline = self.tagline
        beerRealm.abv = self.abv
        beerRealm.desc = self.description
        beerRealm.imageURL = self.image_url
        
        let list = List<getType>()
        self.food_pairing_searched.forEach { (food) in
            let type = getType()
            type.text = food
            list.append(type)
        }

        beerRealm.food_pairing_searched = list
       
        return beerRealm
    }
}
