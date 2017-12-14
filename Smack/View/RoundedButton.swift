//
//  RoundedButton.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-07.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

@IBDesignable

class RoundedButton: UIButton {
    
    // Create the ability to change our Corner Radius inside of InterFace Builder.
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    } // End Corner Radius.
    
    
    // Awake From Nib Function
    override func awakeFromNib() {
        self.setUpView()
    } // End Awake From Nib.
    
    
    // Prepare For Interfave Builder Function
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    } // End Prepare For Interface Builder.
    
    
    // Set Up View Function.
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    } // End Set Up View.
    
    
} // End Class.

// RoundedButton:  
