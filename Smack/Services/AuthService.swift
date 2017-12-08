//
//  AuthService.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-07.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import Foundation
import Alamofire

class AuthService {
    
    // Singleton
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    /*
     User Defaults Variables.
     */
    
    // Is Logged In Variable Getter and Setter.
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    
    // Auth Toke Variable Getter and Setter.
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String // Cast as String because defaults value is an Optional any.
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    
    // User Email Variable Getter and Setter.
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    /*
     Functions
     */
    
    
    // Register User Function
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        // Set email to all lowercase.
        let lowerCaseEmail = email.lowercased()
        
        // Header in JSON format
        let header = [
            "Content-Type" : "application/json; charset=utf-8"
        ]
        
        // Body in JSON format
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        // Web Request
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    
} // END Class.





// AuthService: 

