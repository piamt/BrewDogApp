//
//  AppRouter.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit

protocol AppRouterProtocol: class {
    func navigateToNextScene()
}

class AppRouter {
    
    // MARK: - Stored properties
    fileprivate let window: UIWindow
    fileprivate let rootViewController = AppRootViewController()
    
    // MARK: - Initializer
    init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootViewController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func startApplication() {
        let controller = BeerListBuilder.build()
        let navigationController = UINavigationController(rootViewController: controller)
        rootViewController.transition(to: navigationController)
    }
}

extension AppRouter: AppRouterProtocol {
    
    func navigateToNextScene() {
    }
    
}

