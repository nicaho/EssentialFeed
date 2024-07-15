//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/21.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
