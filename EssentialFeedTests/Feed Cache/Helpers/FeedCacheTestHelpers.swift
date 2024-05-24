//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by nicaho on 2024/5/23.
//

import Foundation
import EssentialFeed

func uniqueImage() -> FeedImage {
    FeedImage(id: UUID(), description: "any", location: "any", imageURL: anyURL())
}

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
    let models = [uniqueImage(), uniqueImage()]
    let local = models.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.url) }
    return (models, local)
}

extension Date {
    func minusFeedCacheMaxAge() -> Date {
        adding(days: -7)
    }
    
    func adding(days: Int) -> Date {
        Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }

    func adding(seconds: TimeInterval) -> Date {
        self + seconds
    }
}
