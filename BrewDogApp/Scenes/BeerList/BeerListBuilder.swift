//
//  BeerListBuilder.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation
import Deferred

protocol BeerListPresenterProtocol {
    func viewDidLoad()
    func askedFood(_ food: String)
}

protocol BeerListInteractorProtocol {
    func retrieveData(food: String) -> Task<[BeerViewModel]>
}

protocol BeerListUserInterfaceProtocol: class {
    func configureFor(viewModel: [BeerViewModel])
    func showSpinner()
    func removeSpinner()
}

protocol BeerListRouterProtocol {
    func navigateToNextScene()
}

class BeerListBuilder {

    //MARK: - Configuration
    static func build() -> BeerListViewController {
        let viewController = BeerListViewController()
        let router = BeerListRouter(view: viewController)
        let interactor = BeerListInteractor()
        let presenter = BeerListPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
