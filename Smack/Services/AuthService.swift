//
//  AuthService.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-07.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
        
        // Body in JSON format
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        // Web Request
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    } // END Register User Function.
    
    
    // Login User Function.
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        // Set email to all lowercase.
        let lowerCaseEmail = email.lowercased()
        
        // Body in JSON format
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                 /*
                 Apple way of Parsing JSON
                 */
                
                // JASON Parsing-> Cast as a Dictionary.
                if let json = response.result.value as? Dictionary<String, Any> {
                    // Check to see if our email equals the user key from JSON Object, cast as a String.
                    if let email = json["user"] as? String {
                        // If there is, set userEmail Default Variable as that user JSON Object response.
                        self.userEmail = email
                    }
                    // Create constant token as a String if JSON Object contains a Key "token"
                    if let token = json["token"] as? String {
                        // If we find it, place token value inside authToken Default Variable.
                        self.authToken = token
                    }
                } // END JSON Parsing.
                
                
                /*
                 
                 // SwiftyJSON Parsing
                 
                 guard let data = response.data else { return }
                 let json = JSON(data: data)
                 self.userEmail = json["user"].stringValue
                 self.authToken = json["toek"].stringValue
                 
                 */
                
                
                // Set isLggedIn to true.
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    } // END Login User Function.
    
    
} // END Class.





// AuthService: 

