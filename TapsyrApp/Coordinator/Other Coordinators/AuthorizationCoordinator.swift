//
//  AuthorizationCoordinator.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class AuthorizationCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let authorizationViewController = AuthorizationViewController(viewModel: AuthorizationViewModel(authorizationDataService: AuthorizationDataService()))
        authorizationViewController.coordinator = self
        navigationController.pushViewController(authorizationViewController, animated: true)
    }
    
    func coordinateToProfile(profileID: Int) {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController, profileID: profileID)
        coordinate(to: profileCoordinator)
    }
}
