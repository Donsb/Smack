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
    
    
    // Return UI Color Function
        //-> retreive the UIColour chosen and set in the database.
    func returnUIColor(components: String)-> UIColor {
        
        //  "[0.388235294117647, 0.945098039215686, 0.992156862745098, 1]"
            // Example of what we get back that needs to be converted.
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ") // Tell Scanner to skip over these charaters.
        let comma = CharacterSet(charactersIn: ",") // This will be to find where to stop while scanning.
        scanner.charactersToBeSkipped = skipped // Set what characters to ignore.
        
        var r, g, b, a : NSString?
        
        // Begin Scanning.  It knows once r is set to skipp over the first set of strings as it already scanned it before scanning for g...
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray // Default colour in case we fail unwrapping our Optional NS Strings.
        
        // Unwrap our local variables.
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        // Convert String to Double and Cast as CGFloat.
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        // Create the New UI Color to use.
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        // Return our UIColor.
        return newUIColor
    }
    
    
    // User Logout Function.
    func logoutUser() {
        
        // Set Instance Variables to empty Strings.
        id = ""
        avatarName = ""
        avatarColor = ""
        name = ""
        
        // Set AuthServices to empty Strings.
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
    
} // END Class





// UserDataService:  




















