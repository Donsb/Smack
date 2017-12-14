//
//  CircleImage.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-10.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

@IBDesignable

class CircleImage: UIImageView {
    
    /*
     Functions
     */
    
    
    // Awake From Nib Function.
    override func awakeFromNib() {
        setUpView()
    } // End Awake From Nib.
    
    
    // Set Up View Function.
    func setUpView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    } // End Set Up View.
    
    
    // Prepare For Interface Builder Function.
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    } // End Prepare For Interface Builder.
    
} // END Class.


