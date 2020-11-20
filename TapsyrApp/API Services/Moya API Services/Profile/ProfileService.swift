//
//  ProfileService.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya

enum ProfileService {
    case getProfileData(profileID: Int)
}

extension ProfileService: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        guard let url = URL(string: NetworkManager.environment) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getProfileData(profileID: let profileID): return "/user/info/\(profileID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getProfileData(_): return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .getProfileData(_): return .requestPlain
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
        case .getProfileData(_): return .custom("")
        }
    }
}
