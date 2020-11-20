//
//  OnboardingViewController.swift
//  TapsyrApp
//
//  Created by Sultan on 11/18/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    //MARK: - Views
    var logoImageView: UIImageView!
    var onboardingCollectionView: UICollectionView!
    var bottomView: UIView!
    var registerButton: CustomRectangularButton!
    var alreadyHaveAccountStackView: UIStackView!
    var copyrightLabel: UILabelDeviceClass!
    var pageControl: UIPageControl!
    
    //MARK: - Coordinator
    var coordinator: OnboardingCoordinator?
    
    //MARK: - ViewModel
    var viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupCollectionView()
        registerCollectionViewCells()
        setupConstraints()
    }
    
    //MARK: - Button handlers
    
    @objc func registerButtonTapped(sender: UIButton) {
        coordinator?.coordinateToAuthorization()
    }
}

extension OnboardingViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        bottomView = UIView()
        bottomView.backgroundColor = .white
        
        createLogoImageView()
        createRegisterButton()
        createLabelAndButton()
        createCopyrightLabel()
        createPageControl()
    }
    
    func createLogoImageView() {
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo_image")
        logoImageView.contentMode = .scaleAspectFit
    }
    
    func createRegisterButton() {
        registerButton = CustomRectangularButton(type: .system)
        bottomView.addSubview(registerButton)

        registerButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.top.leading.trailing.equalToSuperview().inset(15)
        }
        registerButton.titleLabel?.font = .italicSystemFont(ofSize: 15)
        registerButton.overrideFontSize(fontSize: 15)
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func createLabelAndButton() {
        alreadyHaveAccountStackView = UIStackView()
        alreadyHaveAccountStackView.axis = .horizontal
        alreadyHaveAccountStackView.alignment = .center
        alreadyHaveAccountStackView.distribution = .fill
        alreadyHaveAccountStackView.spacing = 10
        
        let alreadyHaveAccountLabel = UILabelDeviceClass()
        alreadyHaveAccountLabel.text = "Уже есть аккаунт?"
        alreadyHaveAccountLabel.font = .italicSystemFont(ofSize: 14)
        alreadyHaveAccountLabel.overrideFontSize(fontSize: 14)
        alreadyHaveAccountStackView.addArrangedSubview(alreadyHaveAccountLabel)
        
        let signInButton = UnderlinedButton(type: .system)
        signInButton.isUnderlined = true
        signInButton.setTitle("Войти", for: .normal)
        signInButton.titleLabel?.font = .italicSystemFont(ofSize: 14)
        signInButton.overrideFontSize(fontSize: 14)
        alreadyHaveAccountStackView.addArrangedSubview(signInButton)
        
        bottomView.addSubview(alreadyHaveAccountStackView)
        alreadyHaveAccountStackView.snp.makeConstraints { (make) in
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    func createCopyrightLabel() {
        copyrightLabel = UILabelDeviceClass()
        copyrightLabel.text = "©2019 Tapsyr. Все права защищены."
        copyrightLabel.font = .italicSystemFont(ofSize: 14)
        copyrightLabel.overrideFontSize(fontSize: 14)
        copyrightLabel.textAlignment = .center
        copyrightLabel.textColor = #colorLiteral(red: 0.7018855214, green: 0.7020056248, blue: 0.7018685937, alpha: 1)
        
        bottomView.addSubview(copyrightLabel)
        copyrightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(alreadyHaveAccountStackView.snp.bottom).offset(30)
            make.bottom.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    func createPageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8909484744, green: 0.9300655723, blue: 1, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0.670237422, blue: 0.7408543229, alpha: 1)
    }
    
    func setupConstraints() {
        self.view.addSubview(logoImageView)
        self.view.addSubview(onboardingCollectionView)
        self.view.addSubview(pageControl)
        self.view.addSubview(bottomView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(55)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(onboardingCollectionView.snp.top).offset(-40)
        }
        
        onboardingCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top).offset(-30)
        }
        
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
                
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        onboardingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        onboardingCollectionView.backgroundColor = .white
        onboardingCollectionView.isPagingEnabled = true
        onboardingCollectionView.showsHorizontalScrollIndicator = false
        onboardingCollectionView.showsVerticalScrollIndicator = false
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
    }
    
    func registerCollectionViewCells() {
        onboardingCollectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseID)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPosition)
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfOnboardingData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.reuseID, for: indexPath) as! OnboardingCollectionViewCell
        
        let cellViewModel = viewModel.onboardingCollectionViewCellViewModel(atIndexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: onboardingCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
