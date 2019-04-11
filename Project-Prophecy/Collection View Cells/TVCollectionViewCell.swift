//
//  TVCollectionViewCell.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko, Scott Welsh, and Sam Zdolshek on 3/27/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import UIKit

class TVCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tv_title: UILabel!
    @IBOutlet weak var tv_releaseDate: UILabel!
    @IBOutlet weak var tv_poster: UIImageView!
    
    func displayContent(title: String, release_date: String, poster: UIImage)
    {
        tv_title.text = title
        tv_releaseDate.text = release_date
        tv_poster.image = poster
    }
}
