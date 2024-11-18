//
//  FeedImageViewModel.swift
//  EssentialFeedTests
//
//  Created by nicaho on 2024/11/14.
//

import Foundation

public struct FeedImageViewModel<Image> {
    public let description: String?
    public let location: String?
    public let image: Image?
    public let isLoading: Bool
    public let shouldRetry: Bool

    public var hasLocation: Bool {
        return location != nil
    }
}
