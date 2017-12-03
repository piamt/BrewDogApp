//
//  BeerListViewModel.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation
import BrewDogCore

struct BeerViewModel {
    let id: Double
    let name: String
    let tagline: String
    let description: String
    let image_url: String
    let abv: Double
    
    init(fromResponse response: BeerResponse) {
        id = response.id
        name = response.name
        tagline = response.tagline
        description = response.description
        image_url = response.image_url
        abv = response.abv //Alcohol By Volume, %
    }
    
    init(fromReducedResponse response: BeerResponse) {
        id = response.id
        name = response.name
        tagline = response.tagline
        description = response.description
        image_url = response.image_url
        abv = response.abv //Alcohol By Volume, %
    }
}
