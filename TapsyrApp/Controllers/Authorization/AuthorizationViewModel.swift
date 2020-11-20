//
//  AuthorizationViewModel.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import PromiseKit

class AuthorizationViewModel {
    
    //MARK: - Moya Provider
    fileprivate let authorizationDataService: AuthorizationDataService
    
    //MARK: - Data Binding Properties
    var networkRequestFailureReason: Box<NetworkRequestFailureReason?> = Box(nil)
    var isAuthCompletedSuccessfully: Box<Bool?> = Box(nil)
    var email: Box<String> = Box(String())
    var password: Box<String> = Box(String())
    var isAllInformationProvided: Box<Bool> = Box(false)
    
    //MARK: - Properties
    private var profileID: Int?
    
    init(authorizationDataService: AuthorizationDataService) {
        self.authorizationDataService = authorizationDataService
    }
    
    func getProfileID() -> Int? {
        return profileID
    }
}

extension AuthorizationViewModel {
    
    func setEmail(email: String?) {
        guard let email = email else {
            self.email.value = ""
            checkAllRequiredInformation()
            return }
        self.email.value = email
        checkAllRequiredInformation()
    }
    
    func setPassword(password: String?) {
        guard let password = password else {
            self.password.value = ""
            checkAllRequiredInformation()
            return }
        self.password.value = password
        checkAllRequiredInformation()
    }
    
    func checkAllRequiredInformation() {
        if !email.value.isBlank && !password.value.isBlank && password.value.count > 2 {
            isAllInformationProvided.value = true
        } else {
            isAllInformationProvided.value = false
        }
    }
}

extension AuthorizationViewModel {
    
    func auth() {

        firstly {
            authorizationDataService.auth(email: email.value, password: password.value)
        }.done { (result) in
            switch result {
                case .success(payload: let userData):
                    self.profileID = userData.id
                    self.isAuthCompletedSuccessfully.value = true
            default: break
            }
        }.catch { (error) in
            self.networkRequestFailureReason.value = error as? NetworkRequestFailureReason
        }
    }
}
