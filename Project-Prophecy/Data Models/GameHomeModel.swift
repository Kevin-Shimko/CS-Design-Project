import Foundation

protocol GameHomeModelProtocol: class {
    func gameItemsDownload(items: NSArray)
}

class GameHomeModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate: GameHomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://prophecyapplication.com/GetVideoGames.php"
    
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
        let videoGames = NSMutableArray()
        
        
        for i in 0 ... jsonResult.count-1
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let game = GameModel()
            
            if let id = jsonElement["id"] as? String,
                let title = jsonElement["title"] as? String,
                let poster_path = jsonElement["poster_path"] as? String,
                let overview = jsonElement["overview"] as? String,
                let release_date = jsonElement["release_date"] as? String
               // let xbox = jsonElement["Xbox"] as? String,
                //let ps4 = jsonElement["PS4"] as? String,
                //let nintendo = jsonElement["Switch"] as? String,
                //let pc = jsonElement["PC"] as? String
            {
                game.gameID = id
                game.title = title
                game.poster_path = poster_path
                game.overview = overview
                game.release_date = release_date
                //game.xbox = xbox
                //game.ps4 = ps4
                //game.nintendo = nintendo
                //game.pc = pc
            }
            
            videoGames.add(game)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.gameItemsDownload(items: videoGames)
        })
    }
    
}
