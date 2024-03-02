import SwiftUI

/// The list of ships.
struct ShipCollectionList: View {
  /// Edit mode binding
  @Environment(\.editMode) private var editMode
  /// Store the data when fetched to a state var.
  @State var dataForLoading: Loadable<[Ship]> = .notLoaded
  /// Store the user favourite selections.
  @State private var favourites = Set<UUID>()
  /// The view model will be a computed property that uses the latest data.
  var viewModel: ShipCollectionViewModel {
    ShipCollectionViewModel(dataForLoading)
  }
  /// The API service
  let dataFetcher = StarShipRetriever()
  
  var body: some View {
    VStack(spacing: 10) {
      if viewModel.isWaiting {
        fetchingDisplay
      }
      if viewModel.isError {
        errorDisplay
      }
      listDisplay
    }
    .padding()
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
    NavigationStack {
      List(viewModel.ships, selection: $favourites) { ship in
        NavigationLink {
          ShipDetails(ship: ship)
        } label: {
            ShipCollectionItem(ship: ship)
            .swipeActions {
              markFavourite(ship.id)
            }
        }
        .if(favourites.contains(ship.id)) { view in
          view.background(Color.cyan)
        }
      }
      .navigationTitle("Star Ships")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  // MARK: - Methods
  func markFavourite(_ id: UUID) -> some View {
    Button(action: {
      favourites.insert(id)
    }) {
      Image(systemName: "heart.fill")
    }
  }
}

#Preview {
  ShipCollectionList()
}
