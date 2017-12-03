//
//  BeerListPresenter.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import Foundation

class BeerListPresenter {

    //MARK: - Stored properties
    fileprivate let router: BeerListRouterProtocol
    fileprivate let interactor: BeerListInteractorProtocol
    fileprivate unowned let view: BeerListUserInterfaceProtocol

    var state: LoadingState<[BeerViewModel]> = .loaded(viewModel: [BeerViewModel]()) {
        didSet {
            switch state {
            case .loading:
                //Show loading view
                view.showSpinner()
                break
            case .loaded(let viewModel):
                view.configureFor(viewModel: viewModel)
            case .error(let error):
                print(error)
                //TODO: show error
                view.removeSpinner()
                break
            }
        }
    }

    //MARK: - Initializer
    init(router: BeerListRouterProtocol,
         interactor: BeerListInteractorProtocol,
         view: BeerListUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension BeerListPresenter: BeerListPresenterProtocol {

    func viewDidLoad() {
        self.state = .loaded(viewModel: [BeerViewModel]())
    }
    
    func askedFood(_ food: String) {
        self.state = .loading
        
        interactor.retrieveData(food: food).upon(.main) { (result) in
            switch result {
            case .failure(let error):
                print(error)
                self.state = .error(AppError.unknown)
            //TODO: Treat error
            case .success(let model):
                print(model)
                self.state = .loaded(viewModel: model)
            }
        }
    }
}
