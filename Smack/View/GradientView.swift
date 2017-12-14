//
//  GradientView.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-06.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

@IBDesignable // See this in storyboard.

class GradientView: UIView {
    
    /*
     Instance Variables
     */
    
    // First colour to use.
    @IBInspectable var topColor: UIColor = UIColor.blue {
        didSet {
            self.setNeedsLayout()
        }
    } // End Top Color.
    
    // Second colour to use.
    @IBInspectable var bottomColor: UIColor = UIColor.green {
        didSet {
            self.setNeedsLayout()
        }
    } // End Bottom Color
    
    
    /*
     Functions
     */
    
    
    // Layout Subviews Function
        //-> Tell it what to do when we set our background colour.
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        
        // Set our two colours
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        // Start start and end point
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        // Set the Size of our GradientLayer to the size of the UIView
        gradientLayer.frame = self.bounds
        
        // Add the gradient Layer to the UIViews layers.
        self.layer.insertSublayer(gradientLayer, at: 0)
    } // End Layout Subviews.
    
    
} // End Class.

// GradientView:  
