//
//  Constants.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-06.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

/*
 URL Constants
 */

let BASE_URL = "https://donslack.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

/*
 Segues
 */

let TO_LOGIN = "toLogin"  // Segue to LoingVC
let TO_CREATE_ACCOUNT = "toCreateAccount"  // Segue to CreateAccountVC
let UNWIND = "unwindToChannel" // Unwind Segue from AccountVC to ChannelVC


/*
 User Defaults
 */

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


/*
 Headers
 */

// Header in JSON format
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]

// Constants: 
