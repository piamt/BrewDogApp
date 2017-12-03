//
//  VehicleResponse.swift
//  Alamofire
//
//  Created by Pia on 12/11/2017.
//

import Foundation
import UIKit
import RealmSwift

public struct UnitCore: DroskyDecodable {
    public let value: Double
    public let unit: String
    
    public init(value: Double, unit: String) {
        self.value = value
        self.unit = unit
    }
    
    enum UnitKeys: String, CodingKey {
        case value = "value"
        case unit = "unit"
    }
}

public struct MashTempCore: DroskyDecodable {
    public let temp: UnitCore
    public let duration: Int?
    
    public init(temp: UnitCore, duration: Int?) {
        self.temp = temp
        self.duration = duration
    }
    
    enum MashTempKeys: String, CodingKey {
        case temp = "temp"
        case duration = "duration"
    }
}

public struct FermentationCore: DroskyDecodable {
    public let temp: UnitCore
   
    
    public init(temp: UnitCore) {
        self.temp = temp
    }
    
    enum FermentationKeys: String, CodingKey {
        case temp = "temp"
    }
}

public struct MethodCore: DroskyDecodable {
    
    public let mash_temp: [MashTempCore]
    public let fermentation: FermentationCore
    public let twist: String?
    
    public init(mash_temp: [MashTempCore], fermentation: FermentationCore, twist: String?) {
        self.mash_temp = mash_temp
        self.fermentation = fermentation
        self.twist = twist
    }
    
    enum MethodKeys: String, CodingKey {
        case value = "value"
        case unit = "unit"
    }
}

public struct MaltCore: DroskyDecodable {
    
    public let name: String
    public let amount: UnitCore
    
    public init(name: String, amount: UnitCore) {
        self.name = name
        self.amount = amount
    }
    
    enum MaltKeys: String, CodingKey {
        case name = "name"
        case amount = "amount"
    }
}

public struct HopsCore: DroskyDecodable {
    
    public let name: String
    public let amount: UnitCore
    public let add: String
    public let attribute: String
    
    public init(name: String, amount: UnitCore, add: String, attribute: String) {
        self.name = name
        self.amount = amount
        self.add = add
        self.attribute = attribute
    }
    
    enum HopsKeys: String, CodingKey {
        case name = "name"
        case amount = "amount"
        case add = "add"
        case attribute = "attribute"
    }
}

public struct IngredientsCore: DroskyDecodable {
    
    let malt: [MaltCore]
    let hops: [HopsCore]
    let yeast: String
    
    public init(malt: [MaltCore], hops: [HopsCore], yeast: String) {
        self.malt = malt
        self.hops = hops
        self.yeast = yeast
    }
    
    enum IngredientsKeys: String, CodingKey {
        case malt = "malt"
        case hops = "hops"
        case yeast = "yeast"
    }
}

public struct BeerResponse: DroskyDecodable {
    
    public let id: Double
    public let name: String
    public let tagline: String
    public let first_brewed: String?
    public let description: String
    public let image_url: String
    public let abv: Double
    public let ibu: Double?
    public let target_fg: Double?
    public let target_og: Double?
    public let ebc: Double?
    public let srm: Double?
    public let ph: Double?
    public let attenuation_level: Double?
    public let volume: UnitCore?
    public let boil_volume: UnitCore?
    public let method: MethodCore?
    public let ingredients: IngredientsCore?
    public let food_pairing: [String]?
    public let brewers_tips: String?
    public let contributed_by: String?
    public var food_pairing_searched: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case first_brewed
        case description
        case image_url
        case abv
        case ibu
        case target_fg
        case target_og
        case ebc
        case srm
        case ph
        case attenuation_level
        case volume
        case boil_volume
        case method
        case ingredients
        case food_pairing
        case brewers_tips
        case contributed_by
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Double.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        tagline = try container.decode(String.self, forKey: .tagline)
        first_brewed = try container.decode(String.self, forKey: .first_brewed)
        description = try container.decode(String.self, forKey: .description)
        image_url = try container.decode(String.self, forKey: .image_url)
        abv = try container.decode(Double.self, forKey: .abv)
        ibu = try container.decode(Double.self, forKey: .ibu)
        target_fg = try container.decode(Double.self, forKey: .target_fg)
        target_og = try container.decode(Double.self, forKey: .target_og)
        if let ebcValue = try? container.decode(Double.self, forKey: .ebc) { ebc = ebcValue } else { ebc = nil }
        if let srmValue = try? container.decode(Double.self, forKey: .srm) { srm = srmValue } else { srm = nil }
        if let phValue = try? container.decode(Double.self, forKey: .ph) { ph = phValue } else { ph = nil }
        attenuation_level = try container.decode(Double.self, forKey: .attenuation_level)
        volume = try container.decode(UnitCore.self, forKey: .volume)
        boil_volume = try container.decode(UnitCore.self, forKey: .boil_volume)
        method = try container.decode(MethodCore.self, forKey: .method)
        ingredients = try container.decode(IngredientsCore.self, forKey: .ingredients)
        food_pairing = try container.decode([String].self, forKey: .food_pairing)
        brewers_tips = try container.decode(String.self, forKey: .brewers_tips)
        contributed_by = try container.decode(String.self, forKey: .contributed_by)
    }
    
    init(id: Double, name: String, tagline: String, abv: Double, description: String, image_url: String, food_pairing_searched: [String]) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.abv = abv
        self.description = description
        self.image_url = image_url
        self.food_pairing_searched = food_pairing_searched
        
        first_brewed = nil
        ibu = nil
        target_fg = nil
        target_og = nil
        ebc = nil
        srm = nil
        ph = nil
        attenuation_level = nil
        volume = nil
        boil_volume = nil
        method = nil
        ingredients = nil
        food_pairing = nil
        brewers_tips = nil
        contributed_by = nil
    }
}
