//
//  UserMovieModel.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko, Scott Welsh, and Sam Zdolshek on 4/7/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import Foundation

class FavoriteModel : NSObject {
    var FavoriteID: String?
    var Title: String?
    var Poster_Path: String?
    var IsFavorite: String?
    var Platform: String?
    var Release_Date: String?
    var Overview: String?
    
    override init(){
        
    }
    
    init(FavoriteID: String, Title: String, Poster_Path: String, IsFavorite: String, Platform: String, Release_Date: String, Overview: String)
    {
        self.FavoriteID = FavoriteID
        self.Title = Title
        self.Poster_Path = Poster_Path
        self.IsFavorite = IsFavorite
        self.Platform = Platform
        self.Release_Date = Release_Date
        self.Overview = Overview
    }
}
