//
//  TelevisionModel.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko, Scott Welsh, and Sam Zdolshek on 3/27/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import Foundation

class UserModel : NSObject {
    var UserID: String?
    var Username: String?
    var Password: String?
    var DisplayName: String?
    var ProfilePicture: String?
    
    override init(){
        
    }
    
    init(UserID: String, Username: String, Password: String, DisplayName: String, ProfilePicture: String)
    {
        self.UserID = UserID
        self.Username = Username
        self.Password = Password
        self.DisplayName = DisplayName
        self.ProfilePicture = ProfilePicture
    }
}
