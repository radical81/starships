import Foundation

struct ShipCollectionViewModel {
  var dataForLoading: Loadable<[Ship]>
  
  init(_ dataForLoading: Loadable<[Ship]>) {
    self.dataForLoading = dataForLoading
  }
  
  // MARK: - Computed Properties
  var ships: [Ship] {
    switch dataForLoading {
    case .loaded(let t):
      return t
    default:
      return []
    }
  }
}
