import Foundation
import _MapKit_SwiftUI

@Observable
final class LocationViewModel {
  // MARK: Public
  var position: MapCameraPosition!
  
  // MARK: Private
  private(set) var locations: [Location] = []
  @ObservationIgnored private let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  
  init() {
    locations = LocationsDataService.locations
    updateMapPosition(with: locations.first!)
  }
  
  // // MARK: Public
  func updateMapPosition(with location: Location) {
    position = MapCameraPosition.region(MKCoordinateRegion(
      center: location.coordinates,
      span: coordinateSpan)
    )
  }
}
