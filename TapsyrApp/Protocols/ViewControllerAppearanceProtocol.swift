//
//  ViewControllerAppearanceProtocol.swift
//  TapsyrApp
//
//  Created by Sultan on 11/18/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

protocol ViewControllerAppearanceProtocol {    
    func setupUI()
}

extension ViewControllerAppearanceProtocol {
    
    func setupConstraints() {}
    func setupNavigationBar() {}
    func setupDelegates() {}
    func setupKeyboard() {}
    func setupTextFields() {}
    func setupTextViews() {}
    func setupPickerViews() {}
    func setupTableView() {}
    func setupCollectionView() {}
    func registerTableViewCells() {}
    func registerCollectionViewCells() {}
    func addGesturesForUIElements() {}
    func removeGesturesFromUIElements() {}
}
