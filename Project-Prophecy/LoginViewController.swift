//
//  LoginViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko, Scott Welsh, and Sam Zdolshek on 4/3/19.
//  Copyright © 2019 KSS. All rights reserved.
// 

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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func LoginButton(_ sender: Any) {
        var login = false
            
        if("Sam" == usernameField.text && "12345" == passwordField.text){
            NSLog("Login Successful")
            login = true
        }
        else if("Kevin" == usernameField.text && "12345" == passwordField.text){
            NSLog("Login Successful")
            login = true
            
        }
        else if("Scott" == usernameField.text && "12345" == passwordField.text){
            NSLog("Login Successful")
            login = true
            
        }
        
        if login == false{
            NSLog("Login Failed")
            self.displayErrorMessage(message: "Username or Password is incorrect")
        }
    }
    
    func displayErrorMessage(message:String){
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default){(action:UIAlertAction) in }
        alertView.addAction(OKAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let tabBarController = segue.destination as! UITabBarController
        let navController = tabBarController.viewControllers![1] as! UINavigationController
        let user = navController.topViewController as! ProfileViewController
        user.globalUsername = usernameField.text!
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
