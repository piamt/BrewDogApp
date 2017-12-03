//
//  AppRootViewController.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit

protocol AppTransitionDelegate: class {
    
    func performTransition(animated: Bool,
                           fromViewController: UIViewController?,
                           toViewController: UIViewController,
                           containerView: UIView,
                           completion: @escaping (Bool) -> Void)
}

class AppRootViewController: UIViewController {
    
    // MARK: - Stored properties
    private(set) var currentViewController: UIViewController?
    weak var transitionDelegate: AppTransitionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Public API
    func transition(to viewController: UIViewController, animated: Bool = true) {
        let fromViewController: UIViewController? = currentViewController
        
        add(viewController: viewController)
        
        let receiver: AppTransitionDelegate = transitionDelegate ?? self
        receiver.performTransition(animated: animated, fromViewController: fromViewController, toViewController: viewController, containerView: view) { [weak self] _ in
            guard let fromViewController = fromViewController else { return }
            self?.remove(viewController: fromViewController)
        }
        
        currentViewController = viewController
    }
    
    // MARK: - Private API
    private func add(viewController: UIViewController) {
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.removeFromParentViewController()
        viewController.view.removeFromSuperview()
    }
}

extension AppRootViewController: AppTransitionDelegate {
    
    func performTransition(animated: Bool,
                           fromViewController: UIViewController?,
                           toViewController: UIViewController,
                           containerView: UIView,
                           completion: @escaping (Bool) -> Void) {
        
        toViewController.view.alpha = 0.0
        
        containerView.addSubviewAndFillSuperview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            if let fromViewController = fromViewController {
                fromViewController.view.transform = fromViewController.view.transform.scaledBy(x: 0.7, y: 0.7)
                fromViewController.view.alpha = 0.0
            }
            
            toViewController.view.alpha = 1.0
            
        }, completion: completion)
    }
}

