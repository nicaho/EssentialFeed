//
//  FeedStoreSpy.swift
//  EssentialFeedTests
//
//  Created by nicaho on 2024/5/22.
//

import Foundation
import EssentialFeed

class FeedStoreSpy: FeedStore {
    enum ReceiveMessage: Equatable {
        case deleteCachedFeed
        case insert([LocalFeedImage], Date)
        case retrieve
    }
    
    private(set) var receiveMessages = [ReceiveMessage]()
    
    private var deleteCompletions = [DeleteCompletion]()
    private var insertionCompletions = [InsertionCompletion]()
    private var retrieveCompletions = [RetrieveCompletion]()
    
    func deleteCachedFeed(completion: @escaping DeleteCompletion) {
        deleteCompletions.append(completion)
        receiveMessages.append(.deleteCachedFeed)
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deleteCompletions[index](.failure(error))
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deleteCompletions[index](.success(()))
    }
    
    func insert(_ items: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        insertionCompletions.append(completion)
        receiveMessages.append(.insert(items, timestamp))
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertionCompletions[index](.failure(error))
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](.success(()))
    }
    
    func retrieve() {
        receiveMessages.append(.retrieve)
    }
    
    func retrieve(completion: @escaping RetrieveCompletion) {
        retrieveCompletions.append(completion)
        receiveMessages.append(.retrieve)
    }
    
    func completeRetrival(with error: Error, at index: Int = 0) {
        retrieveCompletions[index](.failure(error))
    }
    
    func completeRetrivalWithEmptyCache(at index: Int = 0) {
        retrieveCompletions[index](.success(.none))
    }
    
    func completeRetrival(with feed: [LocalFeedImage], timestamp: Date, at index: Int = 0) {
        retrieveCompletions[index](.success(CacheFeed(feed: feed, timestamp: timestamp)))
    }
}
