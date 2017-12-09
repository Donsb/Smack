//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-09.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
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
    
    
    // Cell For Item At Function
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            return cell
        }
        return AvatarCell()
    }
    
    
    // Number Of Sections Function
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    // Number Of Items in Section Function
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28 // We have 28 items in Assets (28 Dark and 28 Light
    }
    
    
} // END Class



// AvatarPickerVC:  


