import UIKit

// class inheritance
class Album {
  var name: String
  init(name: String) {
    self.name = name
  }
  func getPerformance() -> String {
    "Performing songs from album \(name)."
  }
}

// subclass 1: StudioAlbum
class StudioAlbum: Album {
  var studio: String
  init(name: String, studio: String) {
    self.studio = studio
    super.init(name: name)
  }
  override func getPerformance() -> String {
    "Performing songs from studio album \(name)."
  }
}

// subclass 2: LiveAlbum
class LiveAlbum: Album {
  var location: String
  init(name: String, location: String) {
    self.location = location
    super.init(name: name)
  }
  override func getPerformance() -> String {
    "Performing songs from live album \(name)."
  }
}

// create instance of each subclass
var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studio")
var fearless = StudioAlbum(name: "Fearless", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")
var worldTourLive = LiveAlbum(name: "World Tour Live", location: "Worldwide")
// an array to group these instances
var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive, worldTourLive]

for album in allAlbums {
  print(album.getPerformance())
  // this is to prove "polymorphism" nature of inherited instances
  // they can be combined into an [Album] array
  // but they never lose their original class

  // Now type casting to get only live album assets
  if let liveAlbum = album as? LiveAlbum {
    print(
      "This is playing live from \(liveAlbum.location)")
  } else if let studioAlbum = album as? StudioAlbum {
    print("This is released by \(studioAlbum.studio)")
  }
}

