//
//  SocketService.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-12.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    // Singleton
    static let instance = SocketService()
    
    /*
     Initializers
     */
    
    // As this is a NSObject class, we need an init.
    override init() {
        super.init()
    }
    
    // Create Socket
    var manager: SocketManager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    
    /*
     Functions
     */
    
    // Make Connection
    func establishConnection() {
        manager.defaultSocket.connect()
    }
    
    
    // Disconnect
    func closeConnection() {
        manager.defaultSocket.disconnect()
    }
    
    
    // Add Channel Function
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        // If App is sending info to Server, that's an emit.  (same Server to all apps).
            // to receive is a .on
        
        manager.defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    
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
    }
    
    
    
}






// SocketService:  






