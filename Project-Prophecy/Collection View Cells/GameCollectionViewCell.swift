//
//  GameCollectionViewCell.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 3/27/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var game_poster: UIImageView!
    @IBOutlet weak var game_title: UILabel!
    @IBOutlet weak var game_releaseDate: UILabel!
    
    func displayContent(title: String, release_date: String, poster: UIImage)
    {
        game_title.text = title
        game_releaseDate.text = release_date
        game_poster.image = poster
    }
}
