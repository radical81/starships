import Foundation

/// Contract for storage structures.
protocol Storage {
  // MARK: - Properties
  /// Favourite ships key
  var favouriteShipsKey: String { get }
  
  // MARK: - Favourite Ships
  /// Retrieve saved favourite ships
  var favouriteShips: [Ship] { get }
  
  /// Store favourite ship
  func saveShip(_ ship: Ship) throws

  /// Delete favourite ship
  func deleteShip(_ ship: Ship)
  
  /// True if ship is in the collection
  func isFavourite(_ ship: Ship) -> Bool
}
