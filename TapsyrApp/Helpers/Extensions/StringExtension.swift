//
//  StringExtension.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

extension String {
    
    var isBlank: Bool {
        get {
            return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
}
