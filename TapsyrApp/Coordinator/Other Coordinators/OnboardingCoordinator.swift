//
//  OnboardingCoordinator.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let onboardingViewController = OnboardingViewController(viewModel: OnboardingViewModel())
        onboardingViewController.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)        
        navigationController.pushViewController(onboardingViewController, animated: true)
    }
    
    func coordinateToAuthorization() {
        let authorizationCoordinator = AuthorizationCoordinator(navigationController: navigationController)
        coordinate(to: authorizationCoordinator)
    }
}
