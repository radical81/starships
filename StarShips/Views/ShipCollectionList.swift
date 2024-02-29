import SwiftUI

/// The list of ships.
struct ShipCollectionList: View {
  /// Store the data when fetched to a state var.
  @State var dataForLoading: Loadable<[Ship]> = .notLoaded
  /// The view model will be a computed property that uses the latest data.
  var viewModel: ShipCollectionViewModel {
    ShipCollectionViewModel(dataForLoading)
  }
  /// The API service
  let dataFetcher = StarShipRetriever()
  
  var body: some View {
    List(viewModel.ships) {
      ShipCollectionItem(ship: $0)
    }
    .padding()
    .onAppear {
      Task {
        dataForLoading = await dataFetcher.fetchCollection()
      }
    }
  }
}

#Preview {
  ShipCollectionList()
}
