import Foundation
import SwiftUI
import _MapKit_SwiftUI

@Observable
final class LocationViewModel {
  // MARK: Public
  var showLocations = false

  // MARK: Private
  private(set) var position: MapCameraPosition
  private(set) var location: Location {
    didSet { updateMapPosition(with: location) }
  }
  @ObservationIgnored private let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
  let locations: [Location]

  init() {
    let fetchedLocations = LocationsDataService.locations
    let firstLocation = fetchedLocations.first!

    locations = fetchedLocations
    location = firstLocation
    position = MapCameraPosition.region(
      MKCoordinateRegion(
        center: firstLocation.coordinates,
        span: coordinateSpan
      )
    )
  }
  
  // Public Methods
  func setLocation(for location: Location) {
    withAnimation {
      self.location = location
    }
  }
  
  func setNextLocation() {
    guard let currentIndex = locations.firstIndex(where: {$0 == location}) else {
      print("Current location index not found.")
      return
    }
    
    var nextIndex = currentIndex + 1
    if nextIndex >= locations.count {
      nextIndex = 0
    }
    
    setLocation(for: locations[nextIndex])
  }

  // MARK: Private methods
  private func updateMapPosition(with location: Location) {
    position = MapCameraPosition.region(MKCoordinateRegion(
      center: location.coordinates,
      span: coordinateSpan)
    )
  }
}
