//
//  OnboardingViewModel.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class OnboardingViewModel {
    
    //MARK: - Properties
    private var onboardingData = [OnboardingItem]()
    
    init() {
        prepareOnboardingData()
    }
}

extension OnboardingViewModel {
    
    func prepareOnboardingData() {
        onboardingData.append(contentsOf: [OnboardingItem(title: "Сортируйте отходы", description: "Ознакомьтесь, что можно сдать и сортируйте отходы дома.", image: "onboarding_first_image"),
                                           OnboardingItem(title: "Вызовите водителя", description: "Вызовите водителя в удобное для вас время, и получите за это деньги.", image: "onboarding_second_image"),
                                           OnboardingItem(title: "Помогите планете", description: "Сдавайте мусор на переработку, чтобы сохранить будущее.", image: "onboarding_third_image")])
    }
    
    func getNumberOfOnboardingData() -> Int {
        return onboardingData.count
    }
    
    func onboardingCollectionViewCellViewModel(atIndexPath indexPath: IndexPath) -> OnboardingCollectionViewCellViewModel {
        let item = onboardingData[indexPath.row]
        return OnboardingCollectionViewCellViewModel(onboardingItem: item, indexPath: indexPath)
    }
}
