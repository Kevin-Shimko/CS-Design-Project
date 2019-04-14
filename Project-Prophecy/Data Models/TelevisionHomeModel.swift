import Foundation

protocol TVHomeModelProtocol: class {
    func tvItemsDownload(items: NSArray)
}

class TelevisionHomeModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate: TVHomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://prophecyapplication.com/GetTVShows.php"
    
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
        let shows = NSMutableArray()
        
        
        for i in 0 ... jsonResult.count-1
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let tv = TelevisionModel()
            
            if let id = jsonElement["id"] as? String,
                let title = jsonElement["title"] as? String,
                let poster_path = jsonElement["poster_path"] as? String,
                let overview = jsonElement["overview"] as? String,
                let release_date = jsonElement["release_date"] as? String,
                let platform = jsonElement["platform"] as? String
            {
                tv.televisionID = id
                tv.title = title
                tv.poster_path = poster_path
                //tv.backdrop_path = backdrop_path
                tv.overview = overview
                tv.air_date = release_date
                tv.platform = platform
            }
            
            shows.add(tv)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.tvItemsDownload(items: shows)
        })
    }
    
    
}
