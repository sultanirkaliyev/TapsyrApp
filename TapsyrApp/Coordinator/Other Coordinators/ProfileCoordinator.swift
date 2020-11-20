//
//  ProfileCoordinator.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    var profileID: Int
    
    init(navigationController: UINavigationController, profileID: Int) {
        self.navigationController = navigationController
        self.profileID = profileID
    }
    
    func start() {
        let profileViewController = ProfileViewController(viewModel: ProfileViewModel(profileID: profileID, profileDataService: ProfileDataService()))
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
}
