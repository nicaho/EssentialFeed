//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by nicaho on 2024/10/30.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
