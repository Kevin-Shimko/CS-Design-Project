//
//  DetailsViewController.swift
//  Project-Prophecy
//
//  Created by Kevin Shimko on 3/20/19.
//  Copyright © 2019 KSS. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var apiImageLink = "https://image.tmdb.org/t/p/w780/"
    var poster: UIImage = UIImage()
    var id = ""
    
    @IBOutlet var detailsView: UIView!
    
    @IBOutlet weak var details_poster: UIImageView!
    @IBOutlet weak var details_title: UILabel!
    @IBOutlet weak var details_releaseDate: UILabel!
    @IBOutlet weak var details_overview: UILabel!

    @IBOutlet weak var favButton: UIButton!
    

    var movieToReceieve: MovieModel?
    var gameToReceive: GameModel?
    var showToReceive: TelevisionModel?
    var favoriteToReceive: FavoriteModel?
    var objectType : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(objectType == "Movie"){
            details_title.text = movieToReceieve?.title
            GetPoster(posterPath: apiImageLink + movieToReceieve!.poster_path!)
            details_poster.image = poster
            details_overview.text = movieToReceieve?.overview
            details_releaseDate.text = movieToReceieve?.release_date
            id = movieToReceieve!.id!
        }
        else if(objectType == "Game"){
            details_title.text = gameToReceive?.title
            GetPoster(posterPath: gameToReceive!.poster_path!)
            details_poster.image = poster
            details_overview.text = gameToReceive?.overview
            details_releaseDate.text = gameToReceive?.release_date
            id = gameToReceive!.gameID!
        }else if(objectType == "Show"){
            details_title.text = showToReceive?.title
            GetPoster(posterPath: apiImageLink + showToReceive!.poster_path!)
            details_poster.image = poster
            details_overview.text = showToReceive?.overview
            details_releaseDate.text = showToReceive?.air_date
            id = showToReceive!.televisionID!
        }
        else{
            details_title.text = favoriteToReceive?.Title
            GetPoster(posterPath: favoriteToReceive!.Poster_Path!)
            details_poster.image = poster
            details_overview.text = favoriteToReceive?.Overview
            details_releaseDate.text = favoriteToReceive?.Release_Date
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
    
    @IBAction func favAction() {
        print("fav pressed")
        movieToReceieve?.IsFavorite = "1"
        let url = URL(string: "http://prophecyapplication.com/POST.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "favorite": 1,
            "id": id
        ]
        //let postString = "a=\(0)&b=\(id)"
        //request.httpBody = postString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        //print(request.httpBody)
        //request.httpBody = parameters.percentEscaped().data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request){
            data, reponse, error in
            
            if error != nil{
                print("error=\(error)")
                return
            }
            
            //print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString)")
        }
        
        task.resume()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == ""){
            let detail = segue.destinationViewController 
        }
    }*/
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as! HomeViewController
        
    }
}
