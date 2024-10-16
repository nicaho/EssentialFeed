//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by nicaho on 2024/8/20.
//

import Foundation
import EssentialFeed

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool

    var hasLocation: Bool {
        return location != nil
    }
}
