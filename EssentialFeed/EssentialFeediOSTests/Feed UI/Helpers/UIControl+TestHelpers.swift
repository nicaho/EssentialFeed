//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by nicaho on 2024/8/6.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach{ target in
            actions(forTarget: target, forControlEvent: event)?.forEach{
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
