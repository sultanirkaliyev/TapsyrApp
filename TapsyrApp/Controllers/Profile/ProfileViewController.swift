//
//  ProfileViewController.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    //MARK: - Views
    var tableViewHeaderView: ProfileHeaderView!
    var tableView: UITableView!
    
    //MARK: - Coordinator
    var coordinator: ProfileCoordinator?
    
    //MARK: - ViewModel
    var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UIViewController lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.layoutTableHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        registerTableViewCells()
        bindData()
        self.showLoadingWithText(text: "Загружаем профиль...")
    }
    
    //MARK: - MVVM Data Binding
    
    func bindData() {
        
        viewModel.networkRequestFailureReason.bind { [weak self] in
            guard let value = $0 else { return }
            print("Error: \(value.heading) - \(value.description)")
        }
        
        viewModel.userProfileName.bind { [weak self] in
            guard let value = $0 else { return }
            self?.tableViewHeaderView.profileFullNameLabel.text = value
        }
        
        viewModel.userProfileAvatar.bind { [weak self] in
            guard let value = $0, let url = URL(string: value) else { return }
            self?.tableViewHeaderView.profileImageView.sd_setImage(with: url, placeholderImage: nil)
        }
        
        viewModel.isProfileDataSuccessfullyFetched.bind { [weak self] in
            guard let value = $0 else { return }
            self?.hideLoading()
            if value {
                self?.tableView.reloadData()
            }
        }
    }
}

extension ProfileViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        createTableViewHeaderView()
        createTableView()
        setupConstraints()
    }
    
    func setupNavigationBar() {
        self.title = "Профиль"
        let backButton = UIBarButtonItem()
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
    }
    
    func createTableViewHeaderView() {
        tableViewHeaderView = ProfileHeaderView()
        tableViewHeaderView.profileImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    func createTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.tableHeaderView = tableViewHeaderView
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupConstraints() {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func registerTableViewCells() {
        tableView.register(ProfileInfoTableViewCell.self, forCellReuseIdentifier: ProfileInfoTableViewCell.reuseID)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfProfileData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTableViewCell.reuseID, for: indexPath) as? ProfileInfoTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.profileInfoTableViewCellViewModel(atIndexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}
