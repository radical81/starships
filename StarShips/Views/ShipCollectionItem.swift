import SwiftUI

/// Displays an item in the list of ships.
struct ShipCollectionItem: View {
  
  @State var ship: Ship
  
  var body: some View {
    HStack {
      Text(ship.name)
      Text(ship.model)
    }
  }
}

#Preview {
  ShipCollectionItem(ship: Ship(id: "1", name: "Ship", model: "Mini"))
}
