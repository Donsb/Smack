//
//  AvatarCell.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-09.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

// Enum for Avatar Types
enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    /*
     Functions
     */
    
    
    // Awake From Nib Function
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    
    // Set Up View Function
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true // avoids the layer doesn't spill ostide the corner radius.
    }
    
    
    // Configuration Cell Function
    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
} // End Class.


// AvatarCell: 




