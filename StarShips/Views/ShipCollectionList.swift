import SwiftUI

/// The list of ships.
struct ShipCollectionList: View {
    @State var shipList: [Ship] = [Ship(name: "Millenium", model: "Falcon"),
                                   Ship(name: "Star", model: "Destroyer")]
    var body: some View {
      List(shipList) {
        ShipCollectionItem(ship: $0)
      }
      .padding()
    }
}

#Preview {
    ShipCollectionList()
}
