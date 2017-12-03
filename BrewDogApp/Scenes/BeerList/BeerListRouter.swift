//
//  BeerListRouter.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation

class BeerListRouter {

    //MARK: - Stored properties
    unowned let view: BeerListViewController

    //MARK: Initializer
    init(view: BeerListViewController) {
        self.view = view
    }
}

extension BeerListRouter: BeerListRouterProtocol {

    func navigateToNextScene() {

    }
}
