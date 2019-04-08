//
//  FavoriteCollectionViewCell.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 4/3/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fav_poster: UIImageView!
    @IBOutlet weak var fav_title: UILabel!
    @IBOutlet weak var fav_releaseDate: UILabel!
    
    func displayContent(name: String, releaseDate: String, image: UIImage){
        fav_title.text = name
        fav_poster.image = image
        fav_releaseDate.text = releaseDate
    }
}
