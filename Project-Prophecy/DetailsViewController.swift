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
    
    @IBOutlet var detailsView: UIView!
    
    @IBOutlet weak var details_poster: UIImageView!
    @IBOutlet weak var details_title: UILabel!
    @IBOutlet weak var details_releaseDate: UILabel!
    @IBOutlet weak var details_overview: UILabel!
    
    var movieToReceieve: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        details_title.text = movieToReceieve?.title
        GetPoster(posterPath: movieToReceieve!.poster_path!)
        details_poster.image = poster
        details_overview.text = movieToReceieve?.overview
        details_releaseDate.text = movieToReceieve?.release_date
    }
    
    func GetPoster(posterPath: String){
        let apiCall = apiImageLink + posterPath
        if let url = URL(string: apiCall){
            do {
                let data = try Data(contentsOf: url)
                poster = UIImage(data: data)!
            } catch let err{
                print("Error : \(err.localizedDescription)")
            }
        }
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
 
    
 
    
    

}
