//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by nicaho on 2024/8/6.
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach{ target in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach{
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
