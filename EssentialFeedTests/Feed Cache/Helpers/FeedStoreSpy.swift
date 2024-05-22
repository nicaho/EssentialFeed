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
        deleteCompletions[index](error)
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deleteCompletions[index](nil)
    }
    
    func insert(_ items: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        insertionCompletions.append(completion)
        receiveMessages.append(.insert(items, timestamp))
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertionCompletions[index](error)
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](nil)
    }
    
    func retrieve() {
        receiveMessages.append(.retrieve)
    }
    
    func retrieve(completion: @escaping RetrieveCompletion) {
        retrieveCompletions.append(completion)
        receiveMessages.append(.retrieve)
    }
    
    func completeRetrival(with error: Error, at index: Int = 0) {
        retrieveCompletions[index](error)
    }
}
