//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by nicaho on 2024/6/13.
//

import XCTest
import EssentialFeed

extension FeedStoreSpecs where Self: XCTestCase {
    @discardableResult
    func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
        let exp = expectation(description: "Wait for cache insertion")
        
        var insertionError: Error?
        sut.insert(cache.feed, timestamp: cache.timestamp) { receivedInsertionError in
            insertionError = receivedInsertionError
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return insertionError
    }
    
    @discardableResult
    func deleteCache(from sut: FeedStore) -> Error? {
        let exp = expectation(description: "Wait for cache deletion")
        
        var deletionError: Error?
        sut.deleteCachedFeed{ receivedDeletionError in
            deletionError = receivedDeletionError
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return deletionError
    }
    
    func expect(_ sut: FeedStore, toRetirveTwice expectedResult: RetrieveCacheFeedResult, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetirve: expectedResult, file: file, line: line)
        expect(sut, toRetirve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: FeedStore, toRetirve expectedResult: RetrieveCacheFeedResult, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { retrieveResult in
            switch (expectedResult, retrieveResult) {
            case (.empty, .empty), (.failure, .failure):
                break
            case let (.found(expectedFeed, expectedTimestamp), .found(retrieveFeed, retrieveTimestamp)):
                XCTAssertEqual(expectedFeed, retrieveFeed, file: file, line: line)
                XCTAssertEqual(expectedTimestamp, retrieveTimestamp, file: file, line: line)
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrieveResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
}
