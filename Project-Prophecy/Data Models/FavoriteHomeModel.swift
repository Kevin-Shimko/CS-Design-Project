import Foundation

protocol FavoriteHomeModelProtocol: class {
    func favoriteItemsDownload(items: NSArray)
}

class FavoriteHomeModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate: FavoriteHomeModelProtocol!
    
    var data = Data()
    
    var currentUser:String = ""
    
    //let urlPath: String = "http://prophecyapplication.com/GetUserMovies.php"
    
    func downloadItems(){
        //let url: URL = URL(string: "http://prophecyapplication.com/GetUserMovies.php")!

        if(currentUser == "Sam"){
            let url: URL = URL(string: "http://prophecyapplication.com/GetSamFavorites.php")!
            let config = URLSessionConfiguration.default
            // config.requestCachePolicy = .reloadIgnoringLocalCacheData
            // config.urlCache = nil
            //let session = URLSession.init(configuration: config)
            let defaultSession = Foundation.URLSession.init(configuration: config)
            // URLCache.shared.removeAllCachedResponses()
            //URLCache.shared.diskCapacity = 0
            //URLCache.shared.memoryCapacity = 0
            
            let task = defaultSession.dataTask(with: url)        { (data, response, error) in
                
                if error != nil{
                    print("Failed to download data")
                }else{
                    print("Data downloaded")
                    self.parseJSON(data!)
                }
            }
            
            task.resume()
        }
        else if(currentUser == "Kevin"){
            let url: URL = URL(string: "http://prophecyapplication.com/GetKevinFavorites.php")!
            let config = URLSessionConfiguration.default
            // config.requestCachePolicy = .reloadIgnoringLocalCacheData
            // config.urlCache = nil
            //let session = URLSession.init(configuration: config)
            let defaultSession = Foundation.URLSession.init(configuration: config)
            // URLCache.shared.removeAllCachedResponses()
            //URLCache.shared.diskCapacity = 0
            //URLCache.shared.memoryCapacity = 0
            
            let task = defaultSession.dataTask(with: url)        { (data, response, error) in
                
                if error != nil{
                    print("Failed to download data")
                }else{
                    print("Data downloaded")
                    self.parseJSON(data!)
                }
            }
            
            task.resume()
        }
        else{
            let url: URL = URL(string: "http://prophecyapplication.com/GetScottFavorites.php")!
            let config = URLSessionConfiguration.default
            // config.requestCachePolicy = .reloadIgnoringLocalCacheData
            // config.urlCache = nil
            //let session = URLSession.init(configuration: config)
            let defaultSession = Foundation.URLSession.init(configuration: config)
            // URLCache.shared.removeAllCachedResponses()
            //URLCache.shared.diskCapacity = 0
            //URLCache.shared.memoryCapacity = 0
            
            let task = defaultSession.dataTask(with: url)        { (data, response, error) in
                
                if error != nil{
                    print("Failed to download data")
                }else{
                    print("Data downloaded")
                    self.parseJSON(data!)
                }
            }
            
            task.resume()
        }
        

    }
    
    func parseJSON(_ data:Data) {
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }  catch let error as NSError {
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let favorites = NSMutableArray()
        
        
        for i in 0 ... jsonResult.count-1
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let favorite = FavoriteModel()
            
            if let FavoriteID = jsonElement["id"] as? String,
                let Title = jsonElement["title"] as? String,
                let Poster_Path = jsonElement["poster_path"] as? String,
                let Overview = jsonElement["overview"] as? String,
                let Release_Date = jsonElement["release_date"] as? String,
                let Platform = jsonElement["platform"] as? String,
                let IsFavorite = jsonElement["IsFavorite"] as? String
            {
                favorite.FavoriteID = FavoriteID
                favorite.Title = Title
                favorite.Poster_Path = Poster_Path
                favorite.IsFavorite = IsFavorite
                favorite.Platform = Platform
                favorite.Release_Date = Release_Date
                favorite.Overview = Overview
            }
            
            if(favorite.IsFavorite == "1"){
                favorites.add(favorite)
            }
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.favoriteItemsDownload(items: favorites)
        })
    }
    
    
}
