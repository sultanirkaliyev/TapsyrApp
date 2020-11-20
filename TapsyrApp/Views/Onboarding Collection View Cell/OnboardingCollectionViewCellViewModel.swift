//
//  OnboardingCollectionViewCellViewModel.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class OnboardingCollectionViewCellViewModel {
    
    var onboardingImage: String {
        return onboardingItem.image
    }
    
    var onboardingTitle: String {
        return onboardingItem.title
    }
    
    var onboardingDescription: String {
        return onboardingItem.description
    }
    
    var onboardingItem: OnboardingItem
    var indexPath: IndexPath
    
    init(onboardingItem: OnboardingItem, indexPath: IndexPath) {
        self.onboardingItem = onboardingItem
        self.indexPath = indexPath
    }
}
