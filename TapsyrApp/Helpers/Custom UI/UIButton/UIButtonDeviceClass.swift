//
//  UIButtonDeviceClass.swift
//  TapsyrApp
//
//  Created by Sultan on 11/18/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class UIButtonDeviceClass: UIButton {

    @IBInspectable var iPhoneFontSize:CGFloat = 0 {
        didSet {
            overrideFontSize(fontSize: iPhoneFontSize)
        }
    }
    
    var calculatedFontSize = CGFloat()
    
    func overrideFontSize(fontSize:CGFloat) {
        
        guard let currentFontName = self.titleLabel?.font.fontName else { return }
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize)
            self.titleLabel?.font = calculatedFont
            self.calculatedFontSize = fontSize
            break
        case 568.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize)
            self.titleLabel?.font = calculatedFont
            self.calculatedFontSize = fontSize
            break
        case 667.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize + 2)
            self.titleLabel?.font = calculatedFont
            self.calculatedFontSize = fontSize + 2
            break
        case 736.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize + 2)
            self.titleLabel?.font = calculatedFont
            self.calculatedFontSize = fontSize + 2
            break
        case 812.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize + 3)
            self.titleLabel?.font = calculatedFont
            self.calculatedFontSize = fontSize + 3
            break
        case 896.0:
            calculatedFont = UIFont(name: currentFontName, size: fontSize + 3)
            self.titleLabel?.font = calculatedFont
            self.calculatedFontSize = fontSize + 3
            break
        default: break
        }
    }
    
}
