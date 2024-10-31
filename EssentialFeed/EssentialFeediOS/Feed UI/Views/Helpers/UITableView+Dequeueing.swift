//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by nicaho on 2024/10/10.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
