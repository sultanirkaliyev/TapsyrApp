//
//  ProfileViewModel.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import PromiseKit

class ProfileViewModel {
    
    //MARK: - Moya Provider
    fileprivate let profileDataService: ProfileDataService
    
    //MARK: - Data Binding Properties
    var networkRequestFailureReason: Box<NetworkRequestFailureReason?> = Box(nil)
    var isProfileDataSuccessfullyFetched: Box<Bool?> = Box(nil)
    var userProfileName: Box<String?> = Box(nil)
    var userProfileAvatar: Box<String?> = Box(nil)
    
    //MARK: - Properties
    private var profileID: Int
    private var userProfileData = [(String, String)]()    
    
    init(profileID: Int, profileDataService: ProfileDataService) {
        self.profileID = profileID
        self.profileDataService = profileDataService
        getProfileData()
    }
}

extension ProfileViewModel {
    
    func prepareUserData(userData: UserData) {
        userProfileName.value = userData.name
        userProfileAvatar.value = userData.avatar
        let data = userData.getProfileData()
        userProfileData.append(contentsOf: data)
    }
    
    func getNumberOfProfileData() -> Int {
        return userProfileData.count
    }
    
    func profileInfoTableViewCellViewModel(atIndexPath indexPath: IndexPath) -> ProfileInfoTableViewCellViewModel {
        let profileData = userProfileData[indexPath.row]
        return ProfileInfoTableViewCellViewModel(profileData: profileData)
    }
}

extension ProfileViewModel {
    
    func getProfileData() {
        
        firstly {
            profileDataService.getProfileData(profileID: profileID)
        }.done { (result) in
            switch result {
                case .success(payload: let userData):
                    self.prepareUserData(userData: userData)
                    self.isProfileDataSuccessfullyFetched.value = true
            default: break
            }
        }.catch { (error) in
            self.networkRequestFailureReason.value = error as? NetworkRequestFailureReason
        }
    }
}
