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
    var apiImageLink = "https://image.tmdb.org/t/p/w780/"
    
    var poster: UIImage = UIImage()
    
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
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Retrieve cell
        let movie_cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell
        
        // Get the location to be shown
        let item: MovieModel = feedItems[indexPath.row] as! MovieModel
        
        //Get Poster background
        let apiCall = apiImageLink + item.poster_path!
        if let url = URL(string: apiCall){
            do {
                let data = try Data(contentsOf: url)
                poster = UIImage(data: data)!
            } catch let err{
                print("Error : \(err.localizedDescription)")
            }
        }
        
        movie_cell?.displayContent(title: item.title!,release_date: item.release_date!, poster: poster)

        return movie_cell!
    }

}

