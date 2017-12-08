//
//  UserDataService.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-08.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import Foundation

class UserDataService {
    
    // Singleton.
    static let instance = UserDataService()
    
    /*
     Instance Variables
     */
    
    // Variables for JSON Object when creating an Account.
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    
    /*
     Functions
     */
    
    
    // Setter for Instance Variables.
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    
    // Update Avatar Name Function.
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    
    
}





// UserDataService: 


