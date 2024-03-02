import SwiftUI

/// Represents the data source for the ship detail view.
struct ShipDetailsViewModel {
  var ship: Ship
  var favourites: [Ship]
  
  init(_ ship: Ship, favourites: [Ship]) {
    self.ship = ship
    self.favourites = favourites
  }
  
  // MARK: - Computed properties
  var name: String {
    ship.name
  }
  var model: String {
    ship.model
  }
  /// True if the ship is a favourite.
  var isFavourite: Bool {
    favourites.contains(ship)
  }
  /// Indicator for whether the ship is a favourite.
  var favouriteImage: Image {
    let imageName = favourites.contains(ship) ? "heart" : "heart.slash"
    return Image(systemName: imageName)
  }
}
