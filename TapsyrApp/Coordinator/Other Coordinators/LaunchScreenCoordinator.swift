//
//  LaunchScreenCoordinator.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class LaunchScreenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let launchScreenViewController = LaunchScreenViewController()
        launchScreenViewController.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(launchScreenViewController, animated: true)
    }
    
    func coordinateToOnboarding() {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        coordinate(to: onboardingCoordinator)
    }
}
