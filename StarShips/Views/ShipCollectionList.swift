import SwiftUI

/// The list of ships.
struct ShipCollectionList: View {
  /// User selected sort option.
  @State private var sortOption: SortOption = .name
  /// Persistent storage of favourite ships.
  @State var favourites: [Ship] = Shared.storage.favouriteShips
  /// Store the data when fetched to a state var.
  @State var dataForLoading: Loadable<[Ship]> = .notLoaded
  /// The view model will be a computed property that uses the latest data.
  var viewModel: ShipCollectionViewModel {
    ShipCollectionViewModel(dataForLoading, favourites: favourites, sortBy: sortOption)
  }
  
  var body: some View {
    VStack(spacing: 10) {
      if viewModel.isError {
        errorDisplay
      }
      listDisplay
      if viewModel.isWaiting {
        fetchingDisplay
      }
    }
    .padding()
    .onAppear {
      Task {
        dataForLoading = .loading
        dataForLoading = await Shared.DataFetcher.fetchCollection()
      }
      print(Shared.storage.favouriteShips)
    }
  }
  
  var fetchingDisplay: some View {
    VStack {
      Text("Fetching star ships...")
      ProgressView()
      Spacer()
    }
  }
  
  var errorDisplay: some View {
    Text(viewModel.errorMessage)
      .font(.callout)
      .foregroundColor(.red)
  }
  
  var sortPicker: some View {
    Picker("Sort by:", selection: $sortOption) {
      Text("Name").tag(SortOption.name)
      Text("Model").tag(SortOption.model)
    }
    .pickerStyle(.segmented)
  }
  
  var listDisplay: some View {
    NavigationStack {
      sortPicker
      List(viewModel.sortedShips) { ship in
        NavigationLink {
          ShipDetails(ship: ship, favourites: $favourites)
        } label: {
            ShipCollectionItem(ship: ship)
        }
        .swipeActions {
          toggleFavourite(ship)
        }
        .if(viewModel.isFavourite(ship)) { view in
          view.background(Color.cyan)
        }
      }
      .navigationTitle("Star Ships")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  // MARK: - Methods
  func toggleFavourite(_ ship: Ship) -> some View {
    Button(action: {
      if viewModel.isFavourite(ship) {
        favourites.removeAllWithStore { $0 == ship }
      } else {
        favourites.appendWithStore(ship)
      }
    }) {
      if viewModel.isFavourite(ship) {
        Image(systemName: "heart.slash") // Unmark favourite button
      } else {
        Image(systemName: "heart") // Mark favourite button
      }
    }
  }  
}

#Preview {
  ShipCollectionList()
}
