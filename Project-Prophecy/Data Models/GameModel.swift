//
//  TelevisionModel.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 3/27/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import Foundation

class GameModel : NSObject {
    var gameID: String?
    var title: String?
    var release_date: String?
    var overview: String?
    var poster_path:String?
    var xbox: String?
    var ps4: String?
    var nintendo: String?
    var pc: String?
    
    override init(){
        
    }
    
    init(id: String, title: String, poster_path: String, backdrop_path: String, overview: String, release_date: String, xbox: String, ps4: String, nintendo: String, pc: String)
    {
        self.gameID = id
        self.title = title
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
        self.xbox = xbox
        self.ps4 = ps4
        self.nintendo = nintendo
        self.pc = pc
    }
    
}
