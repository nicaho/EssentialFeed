//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/21.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
