import Foundation

class MovieModel : NSObject {
  
  var movie_id: String?
  var title: String?
  var release_date: String?
    
    override init(){
        
    }
  
  init(movie_id: String, title: String, release_date: String)
  {
      self.movie_id = movie_id
      self.title = title
      self.release_date = release_date

  }
  
  override var description: String {
    return "movie_id: \(String(describing: movie_id)), title: \(String(describing: title)), Release Date: \(String(describing: release_date))"
  }

}
