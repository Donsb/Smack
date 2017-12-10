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
     Instance Variables
     */
    
    var avatarType = AvatarType.dark // default dark.
    
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
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        collectionView.reloadData() // This updates our CollectionView Functions.
    }
    
    
    // Cell For Item At Function
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
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
        return 28 // We have 28 items in Assets (28 Dark and 28 Light)
    }
    
    
    // Collection View Layout Function
        // Size our cells and decide on number of Rows based on device.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // calculate the number of columns and size of cells based on screen size.
        var numberOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            // 320 is the size of the iPhone SE.
            numberOfColumns = 4
        }
        
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        // Take entire width subtract padding of both sides.  Then Subtract Gap bewteen cells.
        // Take the remaining which the the width of the cells and divide by number of columns.
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    
    // Select an Avatar
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        // Dismiss the screen.
        self.dismiss(animated: true, completion: nil)
    }
    
    
} // END Class



// AvatarPickerVC:  


