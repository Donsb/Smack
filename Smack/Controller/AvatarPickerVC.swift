//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-09.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    
    /*
     Functions
     */
    
    
    // View Did Load Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Back Btn Pressed Function.
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Segment Control Changed Function.
    @IBAction func segmentControlChanged(_ sender: Any) {
        
    }
    
} // END Class



// AvatarPickerVC:  



