//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by nicaho on 2024/8/6.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
