//
//  FriendViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko, Scott Welsh, and Sam Zdolshek on 4/7/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FriendHomeModelProtocol {
    
    
    @IBOutlet weak var friend_image: UIImageView!
    @IBOutlet weak var friend_name: UILabel!
    
    @IBOutlet weak var friendFavColllectionView: UICollectionView!
    
    var friendToReceive: UserModel?
    var poster: UIImage = UIImage()
    var feedItems : NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friend_image.layer.borderWidth = 1
        friend_image.layer.masksToBounds = false
        friend_image.layer.borderColor = UIColor.black.cgColor
        friend_image.layer.cornerRadius = friend_image.frame.height/2
        friend_image.clipsToBounds = true

        friend_name.text = friendToReceive?.DisplayName
        GetPoster(posterPath: friendToReceive!.ProfilePicture!)
        friend_image.image = poster
        
        self.friendFavColllectionView.delegate = self
        self.friendFavColllectionView.dataSource = self
        
        let homeModel = FriendHomeModel()
        homeModel.delegate = self
        homeModel.selectedUser = friendToReceive!.Username!
        homeModel.downloadItems()
        // Do any additional setup after loading the view.
    }
    
    func favoriteItemsDownload(items: NSArray) {
        feedItems = items
        self.friendFavColllectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favorite_cell = friendFavColllectionView.dequeueReusableCell(withReuseIdentifier: "friendFavorite_cell", for: indexPath) as? FriendFavoriteCollectionViewCell
        
        let favorite: FavoriteModel = feedItems[indexPath.row] as! FavoriteModel
        print(favorite.Title)
        GetPoster(posterPath: favorite.Poster_Path!)
        
        favorite_cell?.displayContent(name: favorite.Title!, releaseDate: favorite.Release_Date!, image: poster)
        
        return favorite_cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "friendFavoriteDetails"){
            
            let detail = segue.destination as! DetailsViewController
            let indexPaths = self.friendFavColllectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            let favorite: FavoriteModel = feedItems[indexPath.row] as! FavoriteModel
            
            detail.favoriteToReceive = favorite
            detail.objectType = "Favorite"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
