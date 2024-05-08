//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/3.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
