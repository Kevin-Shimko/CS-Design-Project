//
//  FirstViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 2/26/19.
//  Copyright © 2019 KSS. All rights reserved.
// 

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, HomeModelProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedMovie : MovieModel = MovieModel()
    let reuseIdentifier = "movie_cell"
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    
    func itemsDownload(items: NSArray) {
        feedItems = items
        //self.listTableView.reloadData()
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let homeModel = HomeModel()
        //homeModel.downloadItems()
        
        // Retrieve cell
        let movie_cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell
        
        
        // Get the location to be shown
        let item: MovieModel = feedItems[indexPath.row] as! MovieModel
        
        let titleLabel = UILabel()
        let releaseLabel = UILabel()
        
        titleLabel.text = item.title
        releaseLabel.text = item.release_date
        
        movie_cell?.movie_title = titleLabel
        movie_cell?.movie_releaseDate = releaseLabel
        
        // Get references to labels of cell
        //movie_cell?.movie_poster.image = UIImage(named: item.poster_path)
        movie_cell!.movie_title.text = item.title
        movie_cell!.movie_releaseDate!.text = item.release_date
        
        movie_cell?.displayContent(title: item.title!,release_date: item.release_date!)

        return movie_cell!
        
    }
    

}

