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
    }
    
    
    // Awake From Nib Function
    override func awakeFromNib() {
        self.setUpView()
    }
    
    
    // Prepare For Interfave Builder Function
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }
    
    
    // Set Up View Function.
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    }
}

// RoundedButton:  
