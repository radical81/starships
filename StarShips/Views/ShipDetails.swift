//
//  ShipDetails.swift
//  StarShips
//
//  Created by Rex Jason Alobba on 29/2/2024.
//

import SwiftUI

struct ShipDetails: View {
  /// The data for the ship details.
  var ship: Ship
  /// Bind to list of favourites from the collection screen.
  @Binding var favourites: [Ship]
  /// The view model for this view.
  var viewModel: ShipDetailsViewModel {
    ShipDetailsViewModel(ship, favourites: favourites)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
      HStack {
        Text("Name")
          .font(.headline)
          .fontWeight(.bold)
        Spacer()
        Text(viewModel.name)
          .font(.headline)
      }
      HStack {
        Text("Model")
          .font(.subheadline)
          .fontWeight(.bold)
        Spacer()
        Text(viewModel.model)
          .font(.subheadline)
      }
      HStack {
        Text("Manufacturer")
          .font(.subheadline)
          .fontWeight(.bold)
        Spacer()
        Text(viewModel.madeBy)
          .font(.subheadline)
      }
      HStack {
        Text("Starship Class")
          .font(.subheadline)
          .fontWeight(.bold)
        Spacer()
        Text(viewModel.shipClass)
          .font(.subheadline)
      }
      HStack {
        Spacer()
        favouriteIndicator
        Spacer()
      }
      Spacer()
    }
    .padding()
  }
  
  var favouriteIndicator: some View {
    Button(action: {
      if viewModel.isFavourite {
        favourites.removeAllWithStore{ $0 == ship }
      } else {
        favourites.appendWithStore(ship)
      }
    }) {
      viewModel.favouriteImage
    }
  }
}

#Preview {
  ShipDetails(ship: Ship(name: "Test", model: "Generic", manufacturer: "Honda", starShipClass: "cargo"), favourites: .constant([]))
}
