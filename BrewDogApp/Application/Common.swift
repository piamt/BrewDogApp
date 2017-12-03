//
//  Common.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation

enum LoadingState<VM> {
    case loading
    case loaded(viewModel: VM)
    case error(AppError)
}

extension LoadingState {
    var viewModel: VM? {
        switch self {
        case .loaded(let vm):
            return vm
        default:
            return nil
        }
    }
}

enum AppError: Error {
    case APIError
    case unknown
}
