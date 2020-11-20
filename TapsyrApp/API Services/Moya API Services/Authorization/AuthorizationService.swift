//
//  AuthorizationService.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya

enum AuthorizationService {
    case auth(email: String, password: String)
}

extension AuthorizationService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        guard let url = URL(string: NetworkManager.environment) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
            case .auth(_, _): return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .auth(_, _): return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .auth(email: let email, password: let password):
            var parameters = [String: Any]()
            parameters["email"] = email
            parameters["password"] = password
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var authorizationType: AuthorizationType {
        switch self {
        case .auth(_, _): return .custom("")
        }
    }
}
