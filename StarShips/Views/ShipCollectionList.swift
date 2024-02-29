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
    VStack(spacing: 10) {
      Text("Star Ships")
        .font(.title)
      if viewModel.isWaiting {
        fetchingDisplay
      }
      if viewModel.isError {
        errorDisplay
      }
      listDisplay
    }
    .onAppear {
      Task {
        dataForLoading = .loading
        dataForLoading = await dataFetcher.fetchCollection()
      }
    }
  }
  
  var fetchingDisplay: some View {
    VStack {
      Text("Fetching star ships...")
      ProgressView()
    }
  }
  
  var errorDisplay: some View {
    Text(viewModel.errorMessage)
      .font(.callout)
      .foregroundColor(.red)
  }
  
  var listDisplay: some View {
    List(viewModel.ships) {
      ShipCollectionItem(ship: $0)
    }
    .padding()
  }
}

#Preview {
  ShipCollectionList()
}
