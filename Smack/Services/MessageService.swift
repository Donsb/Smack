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
                        //print(self.channels[0].channelTitle)
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
    
    
} // END class






// MessageService:  

















