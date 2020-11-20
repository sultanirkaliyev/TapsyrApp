//
//  CustomRectangularButton.swift
//  TapsyrApp
//
//  Created by Sultan on 11/18/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class CustomRectangularButton: UIButtonDeviceClass {
    
    var indicatorColor : UIColor = .white
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    override var isHighlighted: Bool {
        didSet {
            if oldValue != isHighlighted {
                updateShadow()
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            setupButton()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadow()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomRectangularButton {
    
    func setupButton() {
        
        layer.cornerRadius = 7
        
        if isEnabled {
            setTitleColor(.white, for: .normal)
            backgroundColor = #colorLiteral(red: 0, green: 0.670237422, blue: 0.7408543229, alpha: 1)
            tintColor = .white
            setupShadow()
        } else {
            setTitleColor(#colorLiteral(red: 0.6318035722, green: 0.6511856318, blue: 0.7026691437, alpha: 1), for: .normal)
            backgroundColor = #colorLiteral(red: 0.885776341, green: 0.9102317095, blue: 0.9573131204, alpha: 1)
            tintColor = #colorLiteral(red: 0.6318035722, green: 0.6511856318, blue: 0.7026691437, alpha: 1)
        }
    }
    
    func setupShadow() {
        
        if isEnabled {
            self.setShadowWithColor(color: UIColor.black.withAlphaComponent(0.3), opacity: 1, offset: CGSize(width: 0, height: 1), radius: 4)
        } else {
            self.layer.shadowColor = UIColor.clear.cgColor
        }
    }
    
    func updateShadow() {
        if isEnabled {
            if (isSelected || isHighlighted) && isEnabled {
                buttonTouchedIn()
            } else {
                buttonTouchedOut()
            }
        } else {
            self.layer.shadowColor = UIColor.clear.cgColor
        }
    }
    
    private func buttonTouchedIn() {
        self.layer.shadowColor = UIColor.clear.cgColor
    }
    
    private func buttonTouchedOut() {
        setupShadow()
    }
}

extension CustomRectangularButton {
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)

        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        self.isUserInteractionEnabled = false
        showSpinning()
    }
    
    func hideLoading() {
        DispatchQueue.main.async(execute: {
            if self.activityIndicator != nil {
                self.setTitle(self.originalButtonText, for: .normal)
                self.activityIndicator.stopAnimating()
                self.isUserInteractionEnabled = true
            }
        })
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = indicatorColor
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func centerActivityIndicatorInButton() {
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
