//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/3.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
