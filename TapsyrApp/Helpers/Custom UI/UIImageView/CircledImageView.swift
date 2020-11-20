//
//  CircledImageView.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class CircledImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
    }
    
    func setupImageView() {
        setupImageViewStyle()
    }
    
    func setupImageViewStyle() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        clipsToBounds = true
    }
}
