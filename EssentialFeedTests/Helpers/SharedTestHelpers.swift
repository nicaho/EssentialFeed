//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by nicaho on 2024/5/23.
//

import Foundation

func anyURL() -> URL {
    URL(string: "http://any-url.com/")!
}

func anyError() -> NSError {
    NSError(domain: "any error", code: 0)
}
