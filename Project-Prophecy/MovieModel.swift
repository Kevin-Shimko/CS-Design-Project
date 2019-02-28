import Foundation

class MovieModel : NSObject {
  
  var movie_id: Int?
  var title: String?
  var release_date: Date?
  //var overview: String?
  //var posterPath: String?
    
    override init(){
        
    }
  
  init(movie_id: Int, title: String, release_date: Date)
  {
      self.movie_id = movie_id
      self.title = title
      self.release_date = release_date

  }
  
  override var description: String {
    return "movie_id: \(String(describing: movie_id)), title: \(String(describing: title)), Release Date: \(String(describing: release_date))"
  }

}
