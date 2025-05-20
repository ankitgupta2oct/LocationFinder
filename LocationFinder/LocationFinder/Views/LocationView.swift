import SwiftUI
import MapKit

struct LocationView: View {
  @Environment(LocationViewModel.self) var viewModel: LocationViewModel
  
    var body: some View {
      ZStack {
        Map(position: Binding(
          get: { viewModel.position },
          set: { viewModel.position = $0 }
        )) {
          
        }
        .onMapCameraChange(frequency: .onEnd, { context in
          print("\(context.region.center.longitude) : \(context.region.center.latitude)")
        })
        .mapControlVisibility(.hidden)
        .mapStyle(.hybrid(elevation: .realistic))
      }
    }
}

#Preview {
  let viewModel = LocationViewModel()
    LocationView()
      .environment(viewModel)
}
