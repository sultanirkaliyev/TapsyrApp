//
//  UnderlinedButton.swift
//  TapsyrApp
//
//  Created by Sultan on 11/18/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class UnderlinedButton: UIButtonDeviceClass {
    
    var isUnderlined: Bool = false {
        didSet {
            underlineLabel(isUnderlined: isUnderlined)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        guard let textString = title else { return }
        let attributedString = NSAttributedString(string: textString, attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

extension UnderlinedButton {
    
    func setupButton() {
        setTitleColor(#colorLiteral(red: 0, green: 0.670237422, blue: 0.7408543229, alpha: 1), for: .normal)
        backgroundColor = .clear
        tintColor = #colorLiteral(red: 0, green: 0.670237422, blue: 0.7408543229, alpha: 1)
    }
    
    func underlineLabel(isUnderlined: Bool) {
        
        if isUnderlined {
            guard let textString = self.titleLabel?.text else { return }
            let attributedString = NSAttributedString(string: textString, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            self.setAttributedTitle(attributedString, for: .normal)
        }
    }
}
