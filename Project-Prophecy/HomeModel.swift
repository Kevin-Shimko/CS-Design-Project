import Foundation

protocol HomeModelProtocol: class {
     func itemsDownload(items: NSArray)
}

class HomeModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate: HomeModelProtocol!
    
    var data = Data()

    let urlPath: String = "http://prophecyapplication.com/service.php"
    
    func downloadItems(){
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
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
        let movies = NSMutableArray()
        
        
        for i in 0 ... jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let movie = MovieModel()
            
            if let movie_id = jsonElement["movie_id"] as? Int,
               let title = jsonElement["title"] as? String,
               let release_date = jsonElement["releaseDate"] as? Date
            {
                movie.movie_id = movie_id
                movie.title = title
                movie.release_date = release_date
            }
            
            movies.add(movie)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownload(items: movies)
        })
    }


}
