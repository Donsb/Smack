//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-06.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Close Pressed Action Function.
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
}

// CreateAccountVC: 
