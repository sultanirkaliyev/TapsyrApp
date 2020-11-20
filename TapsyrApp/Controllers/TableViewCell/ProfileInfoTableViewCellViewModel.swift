//
//  ProfileInfoTableViewCellViewModel.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class ProfileInfoTableViewCellViewModel {
    
    var profileData: (String, String)
    
    init(profileData: (String, String)) {
        self.profileData = profileData
    }
}
