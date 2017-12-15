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
            // Cast as String because defaults value is an Optional any.
            return defaults.value(forKey: TOKEN_KEY) as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    
    // User Email Variable Getter and Setter.
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as? String ?? ""
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
        
        // Web Request -> Alamofire Request
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
        
        // Wenb Request -> Alamofire Request
/*
         Changed To Response String.
         */
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            //print("Start of Alamofire request")
            //print(body)
            if response.result.error == nil {
                    //print("Response is nil")
                    guard let data = response.data else { return }
                    do {
                        
                        let json = try JSON(data:data)
                        //print("Login: try \(json)")
                        self.userEmail = json["user"].stringValue
                        self.authToken = json["token"].stringValue
                        
                        //print(response)
                        // Set isLggedIn to true.
                        self.isLoggedIn = true
                        completion(true)
                        
                    } catch {
                        debugPrint(error as Any)
                    }
                
            } else {
                //print("Error in Login User Function")
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    } // END Login User Function.
    
    
    // Create User Function.
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        // Set email to all lowercase.
        let lowerCaseEmail = email.lowercased()
        
        // Body in JSON format
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        
        // Web Request -> Alamofire request.
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                
                print("Error in Create User")
                completion(false)
                debugPrint(response.result.error as Any)
                
            }
        }
    } // END Create User.
    
    
    // Find User By Email Function.
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        // Web Request. This is called after login, so we have access to userEmail for this call.
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            // Debug Issue
//            print("Find User Email: Request Started")
//            print("")
//            print("\(URL_USER_BY_EMAIL)\(self.userEmail)")
//            print("")
//            print("The error is: \(response.result.error as Any)")
            
            if response.result.error == nil {
                //print("Find User Email: Response is nil")
                    guard let data = response.data else { return }
                    self.setUserInfo(data: data)
                    completion(true)
                
            } else {
                //print("Error in AuthService Find User By Email")
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    } // End find user by email.
    
    
    // Set User Info Funcion
    func setUserInfo(data: Data) {
        do {
// Dubug
            //print("Start set User Info")
            let json = try JSON(data: data)
            
            //print("Set User Info: json is \(json)")
            let id = json["_id"].stringValue
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            
            UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
        } catch {
            //print("Error in Set User Info Function")
            debugPrint(error as Any)
        }
    } // End set User Info
    
    
} // END Class.

