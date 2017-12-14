//
//  SocketService.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-12.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit
import SocketIO
import Starscream

class SocketService: NSObject {
    
    // Singleton
    static let instance = SocketService()
    
    /*
     Initializers
     */
    
    // As this is a NSObject class, we need an init.
    override init() {
        super.init()
    } // End init.
    
    // Create Socket
    //let manager: SocketManager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    // This one works better.
    let manager: SocketManager = SocketManager(socketURL: URL(string: BASE_URL)!)
    
    /*
     Functions
     */
    
    // Make Connection
    func establishConnection() {
        manager.defaultSocket.connect()
    } // End Establish Connection.
    
    
    // Disconnect
    func closeConnection() {
        manager.defaultSocket.disconnect()
    } // End Close Connection.
    
    
    // Add Channel Function
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        // If App is sending info to Server, that's an emit.  (same Server to all apps).
            // to receive is a .on
        
        manager.defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    } // End Add Channel.
    
    
    // Detect Channels from the Server
    func getChannel (completion: @escaping CompletionHandler) {
        
        // .on(event: String, callback: NormallCallback)
            // DataArray -> we receive an array with name, desc and id // ack -> Acknowledgment.
        manager.defaultSocket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            // Create a new Channel Object
            let newChannel = Channel(channelTitle: channelName, description: channelDescription, id: channelId)
            
            // Append it to our channels Array.
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    } // End Get Channel.
    
    
    //  Add Messages Function -> Add Messages to API.
    func addMesage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        
        // So I don't have to write UserDataService.instance lots of times.
        let user = UserDataService.instance
        
        // Socket
        manager.defaultSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
        
    } // End Add Message.
    
    
    // Get Chat Message Function
    func getChatMessage(completion: @escaping (_ newMessage: Message)-> Void) {
        
        manager.defaultSocket.on("messageCreated") { (dataArray, ack) in
            
            // Parse through the incoming message object.
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            // Create new Message Object
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            
            // Check to see if the incoming channelID matches the one that we are in & logged in.
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                
            completion(newMessage)
            }
        }
    } // End Get Chat Message.
    
    
    // Get Typing Users Function.
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String : String])-> Void) {
        manager.defaultSocket.on("userTypingUpdate") { (dataArray, ack) in
            
            // Get the Array of Dictionary Strings (username & ChannelId)
            guard let typingUsers = dataArray[0] as? [String : String] else { return }
            
            // Pass into completionHandler the Dictionary of typingUsers.
            completionHandler(typingUsers)
            
        }
    } // End Get Typing Users
    
    
    
} // End Class.

