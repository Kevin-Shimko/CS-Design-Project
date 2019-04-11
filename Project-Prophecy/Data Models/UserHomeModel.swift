import Foundation

protocol UserHomeModelProtocol: class {
    func itemsDownload(items: NSArray)
}

class UserHomeModel: NSObject, URLSessionDataDelegate {
    
    weak var delegate: UserHomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://prophecyapplication.com/GetUsers.php"
    
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
        let users = NSMutableArray()
        
        
        for i in 0 ... jsonResult.count-1
        {
            jsonElement = jsonResult[i] as! NSDictionary
            
            let user = UserModel()
            
            if let userID = jsonElement["UserID"] as? String,
                let username = jsonElement["Username"] as? String,
                let password = jsonElement["Password"] as? String,
                let displayname = jsonElement["DisplayName"] as? String,
                let profilepicture = jsonElement["ProfilePicture"] as? String
            {
                user.UserID = userID
                user.Username = username
                user.Password = password
                user.DisplayName = displayname
                user.ProfilePicture = profilepicture
            }
            
            users.add(user)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownload(items: users)
        })
    }
    
}
