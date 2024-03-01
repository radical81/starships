import Foundation

/// Represents the data source for the ship detail view.
struct ShipDetailsViewModel {
  var ship: Ship
  
  init(_ ship: Ship) {
    self.ship = ship
  }
  
  // MARK: - Computed properties
  var name: String {
    ship.name
  }
  var model: String {
    ship.model
  }
}
