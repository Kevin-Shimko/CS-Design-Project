//
//  LoginViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 4/3/19.
//  Copyright © 2019 KSS. All rights reserved.
// update

import UIKit

class LoginViewController: UIViewController, UserHomeModelProtocol {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    var feedItems: NSArray = NSArray()
    var userToSend: UserModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let userHomeModel = UserHomeModel()
        userHomeModel.delegate = self
        userHomeModel.downloadItems()
    }
    
    func itemsDownload(items: NSArray) {
        feedItems = items
    }

    @IBAction func LoginButton(_ sender: Any) {
        var login = false
        //for i in 0 ... feedItems.count-1
        //{
            //let user = feedItems[i] as! UserModel
            
            if("Sam" == usernameField.text && "12345" == passwordField.text){
                NSLog("Login Successful")
                //userToSend = user
                //login = true
            }
        //}
        
        if login == false{
            NSLog("Login Failed")
        }
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let homeScreen = segue.destination as! FirstViewController
        
        homeScreen.userToReceive = userToSend
    }*/
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
