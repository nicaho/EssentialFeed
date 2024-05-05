//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/5/5.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
    
}
