//
//  ServerResponse.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

struct ServerResponse: Codable {
    let success: Bool?
    let data: UserData?
}
