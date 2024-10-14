//
//  FeedViewControllerTests+Assertions.swift
//  EssentialFeediOSTests
//
//  Created by nicaho on 2024/8/6.
//

import XCTest
import EssentialFeed
import EssentialFeediOS

func assertThat(_ sut: FeedViewController, isRending feed: [FeedImage], file: StaticString = #filePath, line: UInt = #line) {
    guard sut.numberOfRenderedFeedImageViews() == feed.count else {
        return XCTFail("Expected \(feed.count) images, got \(sut.numberOfRenderedFeedImageViews()) instead.", file: file, line: line)
    }
    
    feed.enumerated().forEach{ index, image in
        assertThat(sut, hasViewConfiguredFor: image, at: index)
    }
}

func assertThat(_ sut: FeedViewController, hasViewConfiguredFor image: FeedImage, at index: Int, file: StaticString = #filePath, line: UInt = #line) {
    let view = sut.feedImageView(at: index) as? FeedImageCell
    
    guard let cell = view else {
        return XCTFail("Expected \(FeedImageCell.self) instance, got \(String(describing: view)) instead", file: file, line: line)
    }
    
    let shouldLocationBeVisible = (image.location != nil)
    XCTAssertEqual(cell.isShowingLocation, shouldLocationBeVisible, "Expected `isShowingLocation` to be (\(shouldLocationBeVisible) for image view at index (\(index))", file: file, line: line)
    
    XCTAssertEqual(cell.locationText, image.location, "Expected location text to be \(String(describing: image.location)) for image view at index (\(index))", file: file, line: line)
    
    XCTAssertEqual(cell.descriptionText, image.description, "Expected description text to be \(String(describing: image.description)) for image view at index (\(index)", file: file, line: line)
}
