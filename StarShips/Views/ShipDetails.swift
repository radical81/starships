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
  /// The view model for this view.
  var viewModel: ShipDetailsViewModel {
    ShipDetailsViewModel(ship)
  }
  
  var body: some View {
    VStack {
      Text(viewModel.name)
        .font(.headline)
      Text(viewModel.model)
        .font(.subheadline)
    }
  }
}

#Preview {
  ShipDetails(ship: Ship(name: "Test", model: "Generic"))
}
