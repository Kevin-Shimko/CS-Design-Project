//
//  FirstViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 2/26/19.
//  Copyright © 2019 KSS. All rights reserved.
// 

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, HomeModelProtocol,TVHomeModelProtocol, GameHomeModelProtocol {
    
    var feedItems: NSArray = NSArray()
    var feedTVItems: NSArray = NSArray()
    var feedGameItems: NSArray = NSArray()
    
    var dataToSend: AnyObject?
    //var selectedMovie : MovieModel = MovieModel() //??
    
    //let reuseIdentifier = "movie_cell"
    //let tvReuseIdentifier = "tv_cell"
    var apiImageLink = "https://image.tmdb.org/t/p/w780/"
    
    var poster: UIImage = UIImage()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var game_collectionView: UICollectionView!
    @IBOutlet var tv_collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.tv_collectionView.delegate = self
        self.tv_collectionView.dataSource = self
        
        self.game_collectionView.delegate = self
        self.game_collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        self.view.addSubview(tv_collectionView)
        self.view.addSubview(game_collectionView)
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
        let tvHomeModel = TelevisionHomeModel()
        tvHomeModel.delegate = self
        tvHomeModel.downloadItems()
        
        let gameHomeModel = GameHomeModel()
        gameHomeModel.delegate = self
        gameHomeModel.downloadItems()
    }
    
    func itemsDownload(items: NSArray) {
        feedItems = items
        self.collectionView.reloadData()
    }
    
    func tvItemsDownload(items: NSArray) {
        feedTVItems = items
        self.tv_collectionView.reloadData()
    }
    
    func gameItemsDownload(items: NSArray){
        feedGameItems = items
        self.game_collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of feed items
        if collectionView == self.collectionView{
            return feedItems.count
        }
        else if collectionView == self.game_collectionView{
            return feedGameItems.count
        }
        else{
            return feedTVItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView{
            // Retrieve cell
            let movie_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movie_cell", for: indexPath) as? MovieCollectionViewCell
            
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
        else if collectionView == self.game_collectionView {
            // Retrieve cell
            let game_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "game_cell", for: indexPath) as? GameCollectionViewCell
            
            // Get the location to be shown
            let item: GameModel = feedGameItems[indexPath.row] as! GameModel
            
            //Get Poster background
            let apiCall = item.poster_path!
            if let url = URL(string: apiCall){
                do {
                    let data = try Data(contentsOf: url)
                    poster = UIImage(data: data)!
                } catch let err{
                    print("Error : \(err.localizedDescription)")
                }
            }
            
            game_cell?.displayContent(title: item.title!,release_date: item.release_date!, poster: poster)
            
            return game_cell!
        }
        else{
            let tv_cell = tv_collectionView.dequeueReusableCell(withReuseIdentifier: "tv_cell", for: indexPath) as? TVCollectionViewCell
            
            // Get the location to be shown
            let tv_item: TelevisionModel = feedTVItems[indexPath.row] as! TelevisionModel
            
            //Get Poster background
            let apiCall = apiImageLink + tv_item.poster_path!
            if let url = URL(string: apiCall){
                do {
                    let data = try Data(contentsOf: url)
                    poster = UIImage(data: data)!
                } catch let err{
                    print("Error : \(err.localizedDescription)")
                }
            }
            
            tv_cell?.displayContent(title: tv_item.title!,release_date: tv_item.air_date!, poster: poster)
            
            return tv_cell!
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "MovieDetails"){
            let detail = segue.destination as! DetailsViewController
            let indexPaths = self.collectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            let movie: MovieModel = feedItems[indexPath.row] as! MovieModel
        
            detail.movieToReceieve = movie
            detail.objectType = "Movie"
        }
        else if (segue.identifier == "GameDetails"){
            let detail = segue.destination as! DetailsViewController
            let indexPaths = self.game_collectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            let game: GameModel = feedGameItems[indexPath.row] as! GameModel
            
            detail.gameToReceive = game
            detail.objectType = "Game"
        }
        else{
            let detail = segue.destination as! DetailsViewController
            let indexPaths = self.tv_collectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            let show: TelevisionModel = feedTVItems[indexPath.row] as! TelevisionModel
            
            detail.showToReceive = show
            detail.objectType = "Show"
        }
    }
    
}

