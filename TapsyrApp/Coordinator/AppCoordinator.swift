//
//  AppCoordinator.swift
//  TapsyrApp
//
//  Created by Sultan on 11/18/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

enum AppStartFlow {
    case launchScreen
    case onboarding
}

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController = UINavigationController()
    
    let window: UIWindow
    let initFlow: AppStartFlow
    
    init(window: UIWindow, initFlow: AppStartFlow) {
        self.window = window
        self.initFlow = initFlow
    }
    
    func start() {
        
        switch initFlow {
        case .launchScreen:
            window.rootViewController = navigationController
            let launchScreenCoordinator = LaunchScreenCoordinator(navigationController: navigationController)
            coordinate(to: launchScreenCoordinator)
        case .onboarding:
            window.rootViewController = navigationController
            let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
            coordinate(to: onboardingCoordinator)
        }
        
        window.makeKeyAndVisible()
    }
}
