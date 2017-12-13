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
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"

/*
 Segues
 */

let TO_LOGIN = "toLogin"  // Segue to LoingVC
let TO_CREATE_ACCOUNT = "toCreateAccount"  // Segue to CreateAccountVC
let UNWIND = "unwindToChannel" // Unwind Segue from AccountVC to ChannelVC
let TO_AVATAR_PICKER = "toAvatarPicker"  // Segue to Avatar Picker screen


/*
 Colours
 */

let SMACK_PURPLE_PLACEHOLDER = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)


/*
 Notofication Constants
 */

let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("ChannelSelected")

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

// Bearer Header.
let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]

// Constants:  



















