import SwiftUI

/// Displays an item in the list of ships.
struct ShipCollectionItem: View {
  /// The data for the ship in the list.
  var ship: Ship
  
  var body: some View {
    HStack {
      Text(ship.name)
      Spacer()
      Text(ship.model)
    }
  }
}

#Preview {
  ShipCollectionItem(ship: Ship(name: "Ship", model: "Mini"))
}
