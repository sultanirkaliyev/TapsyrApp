//
//  AuthorizationViewController.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    //MARK: - Views
    var scrollView: UIScrollView!
    var scrollContainerView: UIView!
    var containerView: UIView!
    var logoImageView: UIImageView!
    var segmentedControl: CustomSegmentedControl!
    var stackView: UIStackView!
    var emailView: InputDataBlockView!
    var passwordView: InputDataBlockView!
    var continueButton: CustomRectangularButton!
    var copyrightLabel: UILabelDeviceClass!
    
    //MARK: - Coordinator
    var coordinator: AuthorizationCoordinator?
    
    //MARK: - ViewModel
    var viewModel: AuthorizationViewModel
    
    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIViewController lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        removeKeyboardObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        segmentedControl.setIndex(index: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupKeyboard()
        bindData()
    }
    
    //MARK: - MVVM Data Binding
    
    func bindData() {
        
        viewModel.networkRequestFailureReason.bind { [weak self] in
            guard let value = $0 else { return }
            print("Error: \(value.heading) - \(value.description)")
            self?.continueButton.hideLoading()
        }
        
        viewModel.isAuthCompletedSuccessfully.bind { [weak self] in
            guard let value = $0 else { return }
            
            self?.continueButton.hideLoading()
            
            if value {
                guard let profileID = self?.viewModel.getProfileID() else { return }
                self?.coordinator?.coordinateToProfile(profileID: profileID)
            }
        }
        
        viewModel.isAllInformationProvided.bind { [weak self] in
            let value = $0
            
            if self?.segmentedControl.selectedIndex == 1 {
                self?.continueButton.isEnabled = value
            } else {
                self?.continueButton.isEnabled = false
            }
        }
    }
    
    //MARK: - Button handlers
    
    @objc func continueButtonTapped(sender: UIButton) {
        viewModel.auth()
        continueButton.showLoading()
    }
}

extension AuthorizationViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollContainerView = UIView()
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
            make.width.equalToSuperview()
        }
        
        containerView = UIView()
        scrollContainerView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        createLogoImageView()
        createEmailAndPasswordView()
        createSegmentedControl()
        createContinueButton()
        createCopyrightLabel()
        setupConstraints()
    }
    
    func createLogoImageView() {
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo_image")
        logoImageView.contentMode = .scaleAspectFit
    }
    
    func createEmailAndPasswordView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        
        emailView = InputDataBlockView(title: "Email", isSecureEntry: false, textFieldKeyboardType: .emailAddress)
        emailView.textField.placeholder = "Введите почту"
        emailView.textField.delegate = self
        passwordView = InputDataBlockView(title: "Пароль", isSecureEntry: true, textFieldKeyboardType: .default)
        passwordView.textField.placeholder = "Введите пароль"
        passwordView.textField.delegate = self
        
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
    }
    
    func createSegmentedControl() {
        segmentedControl = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["Регистрация", "Вход"])
        segmentedControl.backgroundColor = .white
        segmentedControl.delegate = self
    }
    
    func createContinueButton() {
        continueButton = CustomRectangularButton(type: .system)
        continueButton.titleLabel?.font = .italicSystemFont(ofSize: 15)
        continueButton.overrideFontSize(fontSize: 15)
        continueButton.setTitle("Далее", for: .normal)
        continueButton.isEnabled = true
        continueButton.addTarget(self, action: #selector(continueButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func createCopyrightLabel() {
        copyrightLabel = UILabelDeviceClass()
        copyrightLabel.text = "©2019 Tapsyr. Все права защищены."
        copyrightLabel.font = .italicSystemFont(ofSize: 14)
        copyrightLabel.overrideFontSize(fontSize: 14)
        copyrightLabel.textAlignment = .center
        copyrightLabel.textColor = #colorLiteral(red: 0.7018855214, green: 0.7020056248, blue: 0.7018685937, alpha: 1)
    }
    
    func setupConstraints() {
        
        containerView.addSubview(logoImageView)
        containerView.addSubview(segmentedControl)
        containerView.addSubview(stackView)
        containerView.addSubview(continueButton)
        
        logoImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(segmentedControl.snp.top).offset(-50)
        }
        
        segmentedControl.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalTo(stackView.snp.top).offset(-30)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top).offset(-50)
        }
        
        continueButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.view.addSubview(copyrightLabel)
        copyrightLabel.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    //Keyboard
    
    func setupKeyboard() {
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        (self.scrollView as! UIScrollView).contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        (self.scrollView as! UIScrollView).contentInset = UIEdgeInsets.zero
    }
}

extension AuthorizationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0.7632750869, green: 0.7858145833, blue: 0.8431053758, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0.9249908328, green: 0.9494506717, blue: 0.9965302348, alpha: 1)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        switch textField {
        case emailView.textField: viewModel.setEmail(email: updatedString)
        case passwordView.textField: viewModel.setPassword(password: updatedString)
        default: break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension AuthorizationViewController: CustomSegmentedControlDelegate {
    
    func change(to index: Int) {
        continueButton.isEnabled = (index == 1) && viewModel.isAllInformationProvided.value
    }
}
