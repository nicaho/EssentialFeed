//
//  EssentialFeedAPIEndToEndTests.swift
//  EssentialFeedAPIEndToEndTests
//
//  Created by nicaho on 2024/5/14.
//

import XCTest
import EssentialFeed

final class EssentialFeedAPIEndToEndTests: XCTestCase {
//    func demo() {
//        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, directory: nil)
//        
//        let configuration = URLSessionConfiguration.default
//        configuration.urlCache = cache
//        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
//        let session = URLSession(configuration: configuration)
//        
//        let url = URL(string: "http://any-url.com")!
//        let request = URLRequest(url: url, cachePolicy: .returnCacheDataDontLoad, timeoutInterval: 30)
//
//        // 在App启动时就要设置（如果设置为全局）
//        URLCache.shared = cache
//    }
    
    // 先注释，为了不影响其他tests
    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {
        switch getFeedResult() {
        case .success(let imageFeed):
            XCTAssertEqual(imageFeed.count, 8, "Expeccted 8 items in the test account account")
            XCTAssertEqual(imageFeed[0], expectedItem(at: 0))
            XCTAssertEqual(imageFeed[1], expectedItem(at: 1))
            XCTAssertEqual(imageFeed[2], expectedItem(at: 2))
            XCTAssertEqual(imageFeed[3], expectedItem(at: 3))
            XCTAssertEqual(imageFeed[4], expectedItem(at: 4))
            XCTAssertEqual(imageFeed[5], expectedItem(at: 5))
            XCTAssertEqual(imageFeed[6], expectedItem(at: 6))
            XCTAssertEqual(imageFeed[7], expectedItem(at: 7))
        case .failure(let error):
            XCTFail("Expected successful feed result, got \(error) instead")
        default:
            XCTFail("Expected successful feed result, got no result instead")
        }
    }
    
    func test_endToEndTestServerGetFeedImageDataResult_matchesFixedTestAccountData() {
        switch getFeedImageDataResult() {
        case let .success(data)?:
            XCTAssertFalse(data.isEmpty, "Expected non-empty image data")
            
        case let .failure(error)?:
            XCTFail("Expected successful image data result, got \(error) instead")
            
        default:
            XCTFail("Expected successful image data result, got no result instead")
        }
    }
    
    // MARK: - Helpers

    private func getFeedResult(file: StaticString = #filePath, line: UInt = #line) -> FeedLoader.Result? {
        // 被重定向，所以没网络有缓存，也返回error
//        let testServerURL = URL(string:"https://static1.squarespace.com/static/5891c5b8d1758ec68ef5dbc2/t/5c52cdd0b8a045df091d2fff/1548930512083/feed-case-study-test-api-feed.json")!
        
        
//        let client = URLSessionHTTPClient()
        let loader = RemoteFeedLoader(url: feedTestServerURL, client: ephemeralClient())
        
        trackForMemoryLeaks(loader, file: file, line: line)
        
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: FeedLoader.Result?
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
         
        return receivedResult
    }
    
    private func getFeedImageDataResult(file: StaticString = #filePath, line: UInt = #line) -> FeedImageDataLoader.Result? {
        let url = feedTestServerURL.appendingPathComponent("73A7F70C-75DA-4C2E-B5A3-EED40DC53AA6/image")
        
        let loader = RemoteFeedImageDataLoader(client: ephemeralClient())
        
        trackForMemoryLeaks(loader, file: file, line: line)
        
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: FeedImageDataLoader.Result?
        _ = loader.loadImageData(from: url) { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        return receivedResult
    }
    
    private var feedTestServerURL: URL {
        URL(string: "https://essentialdeveloper.com/feed-case-study/test-api/feed")!
    }
    
    private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
    
        private func expectedItem(at index: Int) -> FeedImage {
            return FeedImage(
                id: id(at: index),
                description: description(at: index),
                location: location(at: index),
                imageURL: imageURL(at: index))
        }

        private func id(at index: Int) -> UUID {
            return UUID(uuidString: [
                "73A7F70C-75DA-4C2E-B5A3-EED40DC53AA6",
                "BA298A85-6275-48D3-8315-9C8F7C1CD109",
                "5A0D45B3-8E26-4385-8C5D-213E160A5E3C",
                "FF0ECFE2-2879-403F-8DBE-A83B4010B340",
                "DC97EF5E-2CC9-4905-A8AD-3C351C311001",
                "557D87F1-25D3-4D77-82E9-364B2ED9CB30",
                "A83284EF-C2DF-415D-AB73-2A9B8B04950B",
                "F79BD7F8-063F-46E2-8147-A67635C3BB01"
            ][index])!
        }

        private func description(at index: Int) -> String? {
            return [
                "Description 1",
                nil,
                "Description 3",
                nil,
                "Description 5",
                "Description 6",
                "Description 7",
                "Description 8"
            ][index]
        }

        private func location(at index: Int) -> String? {
            return [
                "Location 1",
                "Location 2",
                nil,
                nil,
                "Location 5",
                "Location 6",
                "Location 7",
                "Location 8"
            ][index]
        }

        private func imageURL(at index: Int) -> URL {
            return URL(string: "https://url-\(index+1).com")!
        }
}
