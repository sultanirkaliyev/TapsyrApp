//
//  NetworkManager.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya

enum APIEnvironment {
    case staging
    case qa
    case production
    
    var baseURL: String {
        
        switch self {
        case .staging:    return "http://iqlabs.kz/uparty/public/api"
        case .qa:         return "http://iqlabs.kz/uparty/public/api"
        case .production: return "http://iqlabs.kz/uparty/public/api"
        }
    }
}

struct NetworkManager {
    static let environment: String = APIEnvironment.production.baseURL
}
