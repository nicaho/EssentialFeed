//
//  ErrorView.swift
//  EssentialFeediOS
//
//  Created by nicaho on 2024/10/30.
//

import UIKit

public final class ErrorView: UIView {
//    public var message: String?
    
    @IBOutlet private var label: UILabel!
    
    public var message: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }
    
    public override func awakeFromNib() {
        label.text = nil
    }
}
