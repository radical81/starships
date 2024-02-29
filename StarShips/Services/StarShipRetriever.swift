import Foundation

/// Implements the CollectionRetriever for retrieving star ship data.
struct StarShipRetriever: CollectionRetriever {
  var baseUrl: String {
    "https://swapi.dev/api/starships"
  }
  
  func fetchCollection() async -> Loadable<[Ship]> {
    // TODO: fetch data
    guard let components = URLComponents(string: baseUrl) else {
      return .failed(APIError.malformed("Invalid URL."))
    }
    guard let url = components.url else {
      return .failed(APIError.malformed("Invalid URL."))
    }
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let decoder = JSONDecoder()
    var dataResponse: (Data, URLResponse)?
    do {
      dataResponse = try await URLSession.shared.data(for: request)
    } catch {
      return .failed(APIError.network("Network error or invalid endpoint."))
    }
    guard let response = dataResponse?.1 as? HTTPURLResponse else {
      return .failed(APIError.network("No response from the API."))
    }
    guard let data = dataResponse?.0 else {
      return .failed(APIError.network("Missing data from the API."))
    }
    if response.statusCode == 400 { // Bad request
      return .failed(APIError.badRequest("Bad request, the service cannot handle this."))
    }
    guard response.statusCode == 200,
          let response = try? decoder.decode(Response.self, from: data)
    else {
      return .failed(APIError.unknown)
    }
    return .loaded(response.results)
  }
}
