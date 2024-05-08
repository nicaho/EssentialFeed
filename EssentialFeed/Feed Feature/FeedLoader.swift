//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/3.
//

import Foundation

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
