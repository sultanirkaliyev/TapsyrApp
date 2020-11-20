//
//  UIViewControllerExtension.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

fileprivate var activityIndicatorView: UIView?

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideLoading() {
        activityIndicatorView?.removeFromSuperview()
        activityIndicatorView = nil
    }
    
    func showLoadingWithText(text: String) {
        
        activityIndicatorView = UIView(frame: self.view.bounds)
        activityIndicatorView?.backgroundColor = .white
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        
        let activityIndicatorText = UILabelDeviceClass()
        activityIndicatorText.textAlignment = .center
        activityIndicatorText.textColor = .black
        activityIndicatorText.text = text
        activityIndicatorText.font = .systemFont(ofSize: 14)
        activityIndicatorText.numberOfLines = 3
        activityIndicatorText.overrideFontSize(fontSize: 14)
        
        let stackView = UIStackView(arrangedSubviews: [activityIndicator, activityIndicatorText])
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        stackView.axis = .vertical
        
        activityIndicatorView?.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.view.addSubview(activityIndicatorView!)
    }
}
