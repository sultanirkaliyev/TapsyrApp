//
//  OnboardingCollectionViewCell.swift
//  TapsyrApp
//
//  Created by Sultan on 11/19/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SDWebImage

class OnboardingCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var onboardingImageView: UIImageView!
    @IBOutlet weak var onboardingTitleLabel: UILabelDeviceClass!
    @IBOutlet weak var onboardingDescriptionLabel: UILabelDeviceClass!
    
    //MARK: - Reuse Identifier
    static var reuseID: String = "OnboardingCollectionViewCell"
    
    //MARK: - IndexPath
    var indexPath: IndexPath!
    
    //MARK: - ViewModel
    var viewModel: OnboardingCollectionViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            indexPath = viewModel.indexPath
            
            onboardingImageView.image = UIImage(named: viewModel.onboardingImage)
            onboardingTitleLabel.text = viewModel.onboardingTitle
            onboardingDescriptionLabel.text = viewModel.onboardingDescription
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
