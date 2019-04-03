import Foundation

class MovieModel : NSObject {
  
  var id: String?
  var title: String?
  var poster_path: String?
  var backdrop_path: String?
  var overview: String?
  var release_date: String?

    
    override init(){
        
    }
  
  init(id: String, title: String, poster_path: String, backdrop_path: String, overview: String, release_date: String)
  {
      self.id = id
      self.title = title
      self.poster_path = poster_path
      self.backdrop_path = backdrop_path
      self.overview = overview
      self.release_date = release_date

  }
  
  /*override var description: String {
    return "id: \(id), title: \(title), poster_path: \(poster_path), backdrop_path: \(backdrop_path), overview: \(overview),Release Date: \(release_date)"
  }*/

}
