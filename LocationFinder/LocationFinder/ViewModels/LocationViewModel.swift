import Foundation

@Observable
final class LocationViewModel {
  @ObservationIgnored var locations: [Location] = []
  
  init() {
    locations = LocationsDataService.locations
  }
}
