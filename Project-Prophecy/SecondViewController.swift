//
//  SecondViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 2/26/19.
//  Copyright © 2019 KSS. All rights reserved.
// test

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var profile_username: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profile_image.layer.borderWidth = 1
        profile_image.layer.masksToBounds = false
        profile_image.layer.borderColor = UIColor.black.cgColor
        profile_image.layer.cornerRadius = profile_image.frame.height/2
        profile_image.clipsToBounds = true
    }


}

