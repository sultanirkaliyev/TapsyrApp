//
//  UIButtonExtension.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setShadowWithColor(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat) {
        self.layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        self.layer.shadowOpacity = opacity ?? 1.0
        self.layer.shadowOffset = offset ?? CGSize.zero
        self.layer.shadowRadius = radius 
    }
}
