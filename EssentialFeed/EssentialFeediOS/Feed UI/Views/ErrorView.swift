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
            isVisible ? label.text : nil
        }
        set {
            setMessageAnimated(newValue)
        }
    }
    
    public override func awakeFromNib() {
        label.text = nil
    }
    
    private var isVisible: Bool {
        alpha > 0
    }
    
    private func setMessageAnimated(_ message: String?) {
        if let message = message {
            showAnimated(message)
        } else {
            hideMessageAnimated()
        }
    }
    
    private func showAnimated(_ message: String) {
        label.text = message
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
    
    private func hideMessageAnimated() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { completed in
            if completed {
                self.label.text = nil
            }
        }

    }
}
