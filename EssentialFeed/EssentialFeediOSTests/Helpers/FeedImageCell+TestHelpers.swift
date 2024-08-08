//
//  FeedImageCell+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by nicaho on 2024/8/6.
//

import UIKit
import EssentialFeediOS

extension FeedImageCell {
    func simulateRetryAction() {
        feedImageRetryButton.simulateTap()
    }
    
    var isShowingLocation: Bool {
        !locationContainer.isHidden
    }
    
    var isShowingImageLoadingIndicator: Bool {
        return feedImageContainer.isShimmering
    }
    
    var isShowingRetryAction: Bool {
        !feedImageRetryButton.isHidden
    }
    
    var locationText: String? {
        locationLabel.text
    }
    var descriptionText: String? {
        descriptionLabel.text
    }
    
    var rendredImage: Data? {
        feedImageView.image?.pngData()
    }
}
