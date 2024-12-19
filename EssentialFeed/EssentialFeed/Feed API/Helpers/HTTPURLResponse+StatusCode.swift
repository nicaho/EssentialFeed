//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by nicaho on 2024/12/20.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int {
        200
    }
    
    var isOK: Bool {
        statusCode == HTTPURLResponse.OK_200
    }
}
