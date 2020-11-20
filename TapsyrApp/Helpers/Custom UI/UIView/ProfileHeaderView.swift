//
//  ProfileHeaderView.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    var profileImageView: UIImageView!
    var profileFullNameLabel: UILabelDeviceClass!
    var editProfileButton: UIButtonDeviceClass!
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeaderView {
    
    func setupView() {
        
        backgroundColor = .white
        
        let containerView = UIView()
        
        profileImageView = CircledImageView()
        profileImageView.contentMode = .scaleAspectFill
        
        profileFullNameLabel = UILabelDeviceClass()
        profileFullNameLabel.font = .italicSystemFont(ofSize: 18)
        profileFullNameLabel.overrideFontSize(fontSize: 18)
        profileFullNameLabel.numberOfLines = 0
        
        editProfileButton = UIButtonDeviceClass(type: .system)
        editProfileButton.setTitle("Редактировать данные", for: .normal)
        editProfileButton.setTitleColor(#colorLiteral(red: 0, green: 0.670237422, blue: 0.7408543229, alpha: 1), for: .normal)
        editProfileButton.titleLabel?.font = .italicSystemFont(ofSize: 17)
        editProfileButton.overrideFontSize(fontSize: 17)
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 10
        
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 20
        
        verticalStackView.addArrangedSubview(profileFullNameLabel)
        verticalStackView.addArrangedSubview(editProfileButton)
        
        horizontalStackView.addArrangedSubview(profileImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        containerView.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15).priority(.low)
            make.top.equalToSuperview().inset(30).priority(.low)
            make.bottom.equalToSuperview().inset(10).priority(.low)
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(profileImageView.snp.height).multipliedBy(1.0 / 1.0)
            make.height.equalTo(UIScreen.main.bounds.size.width / 4)
        }
        
        self.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }        
    }
}
