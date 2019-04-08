//
//  FriendCollectionViewCell.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 4/3/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friend_image: UIImageView!
    @IBOutlet weak var friend_name: UILabel!
    
    
    func displayContent(name: String, image: UIImage)
    {
        friend_name.text = name
        friend_image.image = image
        
    }
}
