//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/3.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
