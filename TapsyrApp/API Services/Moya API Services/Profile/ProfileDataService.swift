//
//  ProfileDataService.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

class ProfileDataService {
    
    //MARK: - Request Typealias
    
    typealias RequestProfileDataResult = Result<UserData, NetworkRequestFailureReason>
    
    //MARK: - Token
    
    static let tokenClosure: () -> String = {
        return AuthTokenService.shared.getToken()
    }
    
    static let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
    
    //MARK: - Network Error Handler
    
    fileprivate let networkErrorHandler = NetworkErrorHandler()
    
    //MARK: - Provider
    
    fileprivate let provider = MoyaProvider<ProfileService>(endpointClosure: { (target: ProfileService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Accept": "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    }, manager: DefaultAlamofireSessionManager.shared, plugins: [authPlugin, NetworkLoggerPlugin(verbose: true)])
}

//MARK: - Network Requests

extension ProfileDataService {
    
    func getProfileData(profileID: Int) -> Promise<RequestProfileDataResult> {
        
        return Promise<RequestProfileDataResult> { seal in
            
            provider.request(.getProfileData(profileID: profileID)) { (response) in
                switch response {
                case .success(let result):
                    
                    do {
                        let serverJSON = try JSONDecoder().decode(ServerResponse.self, from: result.data)
                        
                        if let userData = serverJSON.data {
                            seal.fulfill(.success(payload: userData))
                        } else {
                            seal.reject(NetworkRequestFailureReason.parseError)
                        }
                    } catch let error {
                        print(error)
                        seal.reject(NetworkRequestFailureReason.parseError)
                    }
                    
                case .failure(let error):
                    
                    switch error {
                    case .statusCode(let statusCode):
                        seal.reject(self.networkErrorHandler.handleNetworkErrorByStatusCode(statusCode))
                    case .underlying(let error, let response):
                        seal.reject(self.networkErrorHandler.handleNetworkError(error, response))
                    default:
                        seal.reject(NetworkRequestFailureReason.failed)
                    }
                }
            }
        }
    }
}
