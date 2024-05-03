//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/3.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
