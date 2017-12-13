//
//  AddChannelVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-12.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    /*
     Functions
     */
    
    
    // View Did Load Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    // Did Receive Memory Warning Function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Close Model Pressed Function.
    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Create Channel Pressed Function.
    @IBAction func createChannelPressed(_ sender: Any) {
        
        // Set our variables to send to server.
        guard let channelName = nameTxt.text , nameTxt.text != "" else { return }
        guard let channelDesc = chanDesc.text else { return }
        
        // Call the function to send new channel to Server.
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                // Dismiss the popup once created.
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    // Set Up View Function.
    func setUpView() {
    
        //Function to close if tap's outside the pop up.
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        
        // Add closeTouch to our bgView
            //-> mening if the touch bgView it closes the pop up.
        bgView.addGestureRecognizer(closeTouch)
        
        // Set colour and placeholder for name text field
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        
        // Set colour and placeholder for description text field
        chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        
    }
    
    
    // Close Tap Function
        //-> Tap and it closes the pop up.
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}


// AddChannelVC:  


















