class MovieModel : NSObject {
  
  var id: int
  var title: String?
  var releaseDate: Date?
  var overview: String?
  var posterPath: String?
  
  override init(){
  
  }
  
  init(id: int, title: String, releaseDate: String, overview: String, posterPath: String)
  {
      self.id = id
      self.title = title
      self.releaseDate = releaseDate
      self.overview = overview
      self.posterPath = posterPath
  }
  
  override var description: String {
      return "id: \(id), Title: \(title), Release Date: \(releaseDate), Overview: \(overview), Poster Path: \(posterPath)"
  }

}
