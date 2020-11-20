//
//  AuthorizationDataService.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

class AuthorizationDataService {
    
    //MARK: - Request Typealias
    
    typealias RequestAuthResult = Result<UserData, NetworkRequestFailureReason>
    
    //MARK: - Token
    
    static let tokenClosure: () -> String = {
        return AuthTokenService.shared.getToken()
    }
    
    static let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
    
    //MARK: - Network Error Handler
    
    fileprivate let networkErrorHandler = NetworkErrorHandler()
    
    //MARK: - Provider
    
    fileprivate let provider = MoyaProvider<AuthorizationService>(endpointClosure: { (target: AuthorizationService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Accept": "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    }, manager: DefaultAlamofireSessionManager.shared, plugins: [authPlugin, NetworkLoggerPlugin(verbose: true)])
}

//MARK: - Network Requests

extension AuthorizationDataService {
    
    func auth(email: String, password: String) -> Promise<RequestAuthResult> {
        
        return Promise<RequestAuthResult> { seal in
            
            provider.request(.auth(email: email, password: password)) { (response) in
                
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
