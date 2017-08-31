//
//  InsetTextField.swift
//  breakPoint
//
//  Created by Andrei-Sorin Blaj on 31/08/2017.
//  Copyright © 2017 Andrei-Sorin Blaj. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {

    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    func setupView() {
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        
        self.attributedPlaceholder = placeholder
    }

}
