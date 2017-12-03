//
//  BeerListInteractor.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation
import BrewDogCore
import Deferred

class BeerListInteractor {

    //MARK: - Stored properties
    let repository: BrewDogRepositoryType
    
    //MARK: - Initializer
    init(repository: BrewDogRepositoryType = BrewDogRepository()) {
        self.repository = repository
    }
}

extension BeerListInteractor: BeerListInteractorProtocol {

    func retrieveData(food: String) -> Task<[BeerViewModel]> {
        return repository.retrieveBeerList(food: food).map(upon: .main, transform: { (response) in
            response.map { BeerViewModel(fromResponse: $0) }
        })
    }
}
