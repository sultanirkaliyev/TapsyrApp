//
//  LaunchScreenViewController.swift
//  TapsyrApp
//
//  Created by Sultan on 11/20/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SnapKit

class LaunchScreenViewController: UIViewController {

    //MARK: - Views
    var logoImageView: UIImageView!
    var backgroundImageView: UIImageView!
    var copyrightLabel: UILabelDeviceClass!
    
    //MARK: - Coordinator
    var coordinator: LaunchScreenCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.coordinator?.coordinateToOnboarding()
        }
    }
}

extension LaunchScreenViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        createLogoImageView()
        createBackgroundImage()
        createCopyrightLabel()
        setupConstraints()
    }
    
    func createLogoImageView() {
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo_image")
        logoImageView.contentMode = .scaleAspectFit
    }
    
    func createBackgroundImage() {
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "launch_screen_background_image")
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    func createCopyrightLabel() {
        copyrightLabel = UILabelDeviceClass()
        copyrightLabel.text = "©2019 Tapsyr. Все права защищены."
        copyrightLabel.font = .italicSystemFont(ofSize: 14)
        copyrightLabel.overrideFontSize(fontSize: 14)
        copyrightLabel.textAlignment = .center
        copyrightLabel.textColor = #colorLiteral(red: 0.5826249123, green: 0.5827257633, blue: 0.5826116204, alpha: 1)
    }
    
    func setupConstraints() {
        
        self.view.addSubview(logoImageView)
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(copyrightLabel)
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(backgroundImageView.snp.top).offset(-110)
            make.width.equalTo(logoImageView.snp.height).multipliedBy(170/50)
            make.height.equalTo(UIScreen.main.bounds.size.width / 7)
        }
        
        copyrightLabel.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview().inset(15)
        }
    }    
}
