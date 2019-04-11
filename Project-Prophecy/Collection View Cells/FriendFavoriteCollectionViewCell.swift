//
//  FriendFavoriteCollectionViewCell.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko, Scott Welsh, and Sam Zdolshek on 4/7/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import UIKit

class FriendFavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendFav_poster: UIImageView!
    @IBOutlet weak var friendFav_title: UILabel!
    @IBOutlet weak var friendFav_releaseDate: UILabel!
    
    func displayContent(name: String, releaseDate: String, image: UIImage){
        friendFav_title.text = name
        friendFav_poster.image = image
        friendFav_releaseDate.text = releaseDate
    }
}
