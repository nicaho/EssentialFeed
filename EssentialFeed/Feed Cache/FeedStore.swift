//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/21.
//

import Foundation

public enum RetrieveCacheFeedResult {
    case empty
    case found(feed: [LocalFeedImage], timestamp: Date)
    case failure(Error)
}

public protocol FeedStore {
    typealias DeleteCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrieveCompletion = (RetrieveCacheFeedResult) -> Void
    
    func deleteCachedFeed(completion: @escaping DeleteCompletion)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    func retrieve(completion: @escaping RetrieveCompletion)
}
