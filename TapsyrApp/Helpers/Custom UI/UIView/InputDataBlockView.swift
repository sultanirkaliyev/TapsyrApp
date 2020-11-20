//
//  InputDataBlockView.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class InputDataBlockView: UIView {

    private var title: String
    private var isSecureEntry: Bool
    private var textFieldKeyboardType: UIKeyboardType?
    
    var titleLabel: UILabelDeviceClass!
    var textField: CustomTextField!
    
    init(title: String, isSecureEntry: Bool, textFieldKeyboardType: UIKeyboardType?) {
        self.title = title
        self.isSecureEntry = isSecureEntry
        self.textFieldKeyboardType = textFieldKeyboardType
        super.init(frame: .zero)        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputDataBlockView {
    
    func setupView() {
        
        let containerView = UIView()
        
        titleLabel = UILabelDeviceClass()
        titleLabel.text = title
        titleLabel.font = .italicSystemFont(ofSize: 14)
        titleLabel.overrideFontSize(fontSize: 14)
        
        textField = CustomTextField()
        textField.placeholder = "Text here..."
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 7
        textField.layer.borderColor = #colorLiteral(red: 0.9249908328, green: 0.9494506717, blue: 0.9965302348, alpha: 1)
        textField.keyboardType = textFieldKeyboardType ?? UIKeyboardType.default
        textField.isSecureTextEntry = isSecureEntry
        textField.returnKeyType = .done
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(textField)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textField.snp.top).offset(-10)
        }
        
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        } 
    }
}
