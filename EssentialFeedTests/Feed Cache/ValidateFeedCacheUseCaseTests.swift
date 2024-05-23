//
//  ValidateFeedCacheUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by nicaho on 2024/5/23.
//

import XCTest
import EssentialFeed

final class ValidateFeedCacheUseCaseTests: XCTestCase {
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receiveMessages, [])
    }
    
    func test_validate_deletesCacheOnRetrivalError() {
        let (sut, store) = makeSUT()
        
        sut.validateCache()
        store.completeRetrival(with: anyError())
        
        XCTAssertEqual(store.receiveMessages, [.retrieve, .deleteCachedFeed])
    }
    
    func test_validate_doesNotDeletesCacheOnEmptyCache() {
        let (sut, store) = makeSUT()
        
        sut.validateCache()
        store.completeRetrivalWithEmptyCache()
        
        XCTAssertEqual(store.receiveMessages, [.retrieve])
    }
    
    func test_validate_doesNotDeleteOnLessThanSevenDaysCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let lessThanSevenDaysOldTimestamp = fixedCurrentDate.adding(days: -7).adding(seconds: 1)
        let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
        
        sut.validateCache()
        store.completeRetrival(with: feed.local, timestamp: lessThanSevenDaysOldTimestamp)
        
        XCTAssertEqual(store.receiveMessages, [.retrieve])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut: sut, store: store)
    }
}
