//
//  ProfileInfoTableViewCell.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {

    //MARK: - Views
    var infoTitleLabel: UILabelDeviceClass!
    var infoDescriptionLabel: UILabelDeviceClass!
    
    //MARK: - Properties
    static let reuseID = "ProfileInfoTableViewCell"
    
    //MARK: - ViewModel
    var viewModel: ProfileInfoTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            infoTitleLabel.text = viewModel.profileData.0
            infoDescriptionLabel.text = viewModel.profileData.1
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ProfileInfoTableViewCell {
    
    func setupUI() {
        self.selectionStyle = .none
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        
        infoTitleLabel = UILabelDeviceClass()
        infoTitleLabel.textColor = #colorLiteral(red: 0.5418176651, green: 0.5603566766, blue: 0.671943903, alpha: 1)
        infoTitleLabel.font = .italicSystemFont(ofSize: 15)
        infoTitleLabel.overrideFontSize(fontSize: 15)
        infoTitleLabel.numberOfLines = 1
        
        infoDescriptionLabel = UILabelDeviceClass()
        infoDescriptionLabel.font = .italicSystemFont(ofSize: 17)
        infoDescriptionLabel.overrideFontSize(fontSize: 17)
        infoDescriptionLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(infoTitleLabel)
        stackView.addArrangedSubview(infoDescriptionLabel)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(15)
        }
    }
}
