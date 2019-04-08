//
//  SecondViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 2/26/19.
//  Copyright © 2019 KSS. All rights reserved.
// test

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UserHomeModelProtocol, FavoriteHomeModelProtocol {
    
    var feedItems: NSArray = NSArray()
    var feedFavoriteItems: NSArray = NSArray()
    var poster: UIImage = UIImage()
    
//    var movie: MovieModel()
    
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var profile_username: UILabel!
    @IBOutlet weak var friendCollectionView: UICollectionView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        profile_image.layer.borderWidth = 1
        profile_image.layer.masksToBounds = false
        profile_image.layer.borderColor = UIColor.black.cgColor
        profile_image.layer.cornerRadius = profile_image.frame.height/2
        profile_image.clipsToBounds = true
        
        self.friendCollectionView.delegate = self
        self.friendCollectionView.dataSource = self
        
        self.favoriteCollectionView.delegate = self
        self.favoriteCollectionView.dataSource = self
        
        let userHomeModel = UserHomeModel()
        userHomeModel.delegate = self
        userHomeModel.downloadItems()
        
        let favoriteHomeModel = FavoriteHomeModel()
        favoriteHomeModel.delegate = self
        favoriteHomeModel.downloadItems()
    }

    func itemsDownload(items: NSArray) {
        feedItems = items
        
        //Determines User
        let user = feedItems[0] as! UserModel
        
        GetPoster(posterPath: user.ProfilePicture!)
        profile_image.image = poster
        profile_username.text = user.Username
        self.friendCollectionView.reloadData()
        //GetFriends()
    }
    
    func favoriteItemsDownload(items: NSArray) {
        feedFavoriteItems = items
        self.favoriteCollectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of feed items
        if collectionView == friendCollectionView.self{
            return feedItems.count-1
        }
        else{
            return feedFavoriteItems.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == friendCollectionView.self{
            let friend_cell = friendCollectionView.dequeueReusableCell(withReuseIdentifier: "friend_cell", for: indexPath) as? FriendCollectionViewCell
            
            // Get the location to be shown
            let user: UserModel = feedItems[indexPath.row + 1] as! UserModel
            
            //Get Poster background
            GetPoster(posterPath: user.ProfilePicture!)
            
            friend_cell?.displayContent(name: user.DisplayName!, image: poster)
            
            return friend_cell!
        }
    
        else{
            
            let favorite_cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "fav_cell", for: indexPath) as? FavoriteCollectionViewCell
            
            let favorite: FavoriteModel = feedFavoriteItems[indexPath.row] as! FavoriteModel
            
            GetPoster(posterPath: favorite.Poster_Path!)
            
            favorite_cell?.displayContent(name: favorite.Title!, releaseDate: favorite.Release_Date!, image: poster)
            
            return favorite_cell!
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "favoriteDetails"){
            let detail = segue.destination as! DetailsViewController
            let indexPaths = self.favoriteCollectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            let favorite: FavoriteModel = feedFavoriteItems[indexPath.row] as! FavoriteModel
            
            detail.favoriteToReceive = favorite
            detail.objectType = "Favorite"
        }
        
        if(segue.identifier == "friend"){
            let friendDetails = segue.destination as! FriendViewController
            let indexPaths = self.friendCollectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            let friend: UserModel = feedItems[indexPath.row+1] as! UserModel
            
            
            friendDetails.friendToReceive = friend
        }
    }
    
    func GetPoster(posterPath: String){
        if let url = URL(string: posterPath){
            do {
                let data = try Data(contentsOf: url)
                poster = UIImage(data: data)!
            } catch let err{
                print("Error : \(err.localizedDescription)")
            }
        }
    }

}

