//
//  MessageService.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-11.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    // Singleton
    static let instance = MessageService()
    
    /*
     Instance Variables
     */
    
    var channels = [Channel]() // Array of Channels.
    var messages = [Message]() // Array of Messages.
    var selectedChannel: Channel?
    var unreadChannels = [String]()
    
    /*
     Functions
     */
    
    
    //
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        // Web Request
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                // SwiftyJSON version of code:
                guard let data = response.data else { return }
                
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {

                            // Extract the needed info from JSON Object
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue

                            // Create new Channel Object
                            let channel = Channel(channelTitle: name, description: channelDescription, id: id)

                            // Add above channel Object to Instance Variable channels Array
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        completion(true)
                    }
                } catch {
                    debugPrint(error)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    // Find All Messages For Channel Function.
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        
        // Web Request
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                // Clear Messages in Messages Array
                self.clearMessages()
                
                // Populate data variable with our response from server.
                guard let data = response.data else { return }
                
                // JSON Parsing
                do {
                    // populate json variable with the array of JSON Objects.
                    if let json = try JSON(data: data).array {
                        
                        // Extract properties from the JSON Object.
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            // Create new Message struct with it's initializer.
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            
                            // Append the new message to our messages Array.
                            self.messages.append(message)
                            
                        }
                        
                        // Finished - Completion is now true.
                        completion(true)
                        
                    }
                } catch {
                    debugPrint(error as Any)
                }
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
            
        } // END Web Request
        
    }
    
    
    // Function to remove channels
    func clearChannels() {
        channels.removeAll()
    }
    
    
    // Clear Messages Function.
    func clearMessages() {
        messages.removeAll()
    }
    
    
} // END class






// MessageService:  

















