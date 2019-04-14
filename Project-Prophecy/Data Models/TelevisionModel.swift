//
//  TelevisionModel.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko, Scott Welsh, and Sam Zdolshek on 3/27/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import Foundation

class TelevisionModel : NSObject {
    var televisionID: String?
    var title: String?
    var air_date: String?
    var backdrop_path: String?
    var overview: String?
    var poster_path:String?
    var platform:String?
    
    override init(){
        
    }
    
    init(id: String, title: String, poster_path: String, backdrop_path: String, overview: String, air_date: String, platform: String)
    {
        self.televisionID = id
        self.title = title
        self.poster_path = poster_path
        self.backdrop_path = backdrop_path
        self.overview = overview
        self.air_date = air_date
        self.platform = platform
    }
    
}
