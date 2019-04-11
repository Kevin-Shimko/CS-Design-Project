import Foundation

protocol FavoriteHomeModelProtocol: class {
    func favoriteItemsDownload(items: NSArray)
}

class FavoriteHomeModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate: FavoriteHomeModelProtocol!
    
    var data = Data()
    
    //let urlPath: String = "http://prophecyapplication.com/GetUserMovies.php"
    
    func downloadItems(){
        
        let url: URL = URL(string: "http://prophecyapplication.com/GetUserMovies.php")!
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        //let session = URLSession.init(configuration: config)
        let defaultSession = Foundation.URLSession.init(configuration: config)
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        let task = defaultSession.dataTask(with: url)
        { (data, response, error) in
            
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data downloaded")
                self.parseJSON(data!)
            }
        }
        
        task.resume()
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
            
            if let FavoriteID = jsonElement["FavoriteID"] as? String,
                let Title = jsonElement["Title"] as? String,
                let Poster_Path = jsonElement["Poster_Path"] as? String,
                let IsFavorite = jsonElement["IsFavorite"] as? String,
                let EntityID = jsonElement["EntityID"] as? String,
                let Release_Date = jsonElement["Release_Date"] as? String,
                let Overview = jsonElement["Overview"] as? String
            {
                favorite.FavoriteID = FavoriteID
                favorite.Title = Title
                favorite.Poster_Path = Poster_Path
                favorite.IsFavorite = IsFavorite
                favorite.EntityID = EntityID
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
