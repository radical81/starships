import Foundation

/// Convenience functions for managing local storage.
struct LocalStore: Storage {
  // MARK: - Properties
  /// Use user defaults for storage.
  let store = UserDefaults.standard
  /// JSON encoder
  let encoder = JSONEncoder()
  // JSON Decoder
  let decoder = JSONDecoder()

  // MARK: - Protocol Implementation
  /// Favourite ships key
  var favouriteShipsKey: String { "favouriteShips" }
  
  // MARK: - Favourite Ships
  /// Retrieve saved favourite ships
  var favouriteShips: [Ship] {
    if let data = store.data(forKey: favouriteShipsKey) {
      do {
        let ships = try decoder.decode([Ship].self, from: data)
        return ships
      } catch {
        print("Error decoding saved favourite ships. (\(error))")
      }
    }
    return []
  }
  
  /// Store favourite ship
  func saveShip(_ ship: Ship) throws {
    var currentFavourites = favouriteShips
    currentFavourites.removeAll {
      $0 == ship
    }
    currentFavourites.append(ship)
    do {
      let data = try encoder.encode(currentFavourites)
      store.set(data, forKey: favouriteShipsKey)
    } catch {
      throw StoreError.saveFailed("Failed to save ship. Please try again.")
    }
  }

  /// Delete favourite ship
  func deleteShip(_ ship: Ship) {
    var currentFavourites = favouriteShips
    currentFavourites.removeAll {
      $0 == ship
    }
    do {
      let data = try encoder.encode(currentFavourites)
      store.set(data, forKey: favouriteShipsKey)
    } catch {
      print("Error encoding ship. (\(error)")
    }
  }
}
