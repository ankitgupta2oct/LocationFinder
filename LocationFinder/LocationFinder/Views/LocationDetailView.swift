import SwiftUI
import _MapKit_SwiftUI

struct LocationDetailView: View {
  @Environment(LocationViewModel.self) var viewModel
  let location: Location
    var body: some View {
      ScrollView {
        VStack(alignment: .leading, spacing: 20) {
          locationDetailImageView
          
          VStack(alignment: .leading) {
            locationHeading
            Divider()
            locationDescription
            Divider()
            mapLocation
          }
          .padding()
        }
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
          Button {
            viewModel.locationDetail = nil
          } label: {
            Image(systemName: "xmark")
              .foregroundStyle(.black)
              .font(.title2)
              .bold()
              .padding()
              .background(.white)
              .clipShape(.circle)
          }
          .shadow(radius: 10)
          .padding(10)
        }
      }
    }
}

extension LocationDetailView {
  private var locationDetailImageView: some View {
    TabView {
      ForEach(location.imageNames, id: \.self) { image in
        Tab {
          Image(image)
            .resizable()
        }
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .tabViewStyle(.page)
  }
  
  private var locationHeading: some View {
    VStack(alignment: .leading) {
      Text(location.name)
        .bold()
        .font(.title2)
      Text(location.cityName)
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
  }
  
  private var locationDescription: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(location.description)
        .font(.body)
        .foregroundStyle(.primary)
      if let link = URL(string: location.link) {
        Link("Learn More", destination: link)
          .foregroundStyle(.blue)
      }
    }
  }
  
  private var mapLocation: some View {
    Map(position: .constant(
      MapCameraPosition.region(
        MKCoordinateRegion(
          center: location.coordinates,
          span: viewModel.coordinateSpan))),
        interactionModes: []
    ) {
      Annotation(location.name, coordinate: location.coordinates) {
        MapMarkerView()
          .scaleEffect(viewModel.location == location ? 1.0 : 0.7)
          .onTapGesture {
            viewModel.setLocation(for: location)
          }
      }
    }
    .aspectRatio(1, contentMode: .fit)
  }
}

#Preview {
  let viewModel = LocationViewModel()
  LocationDetailView(location: viewModel.location)
    .environment(viewModel)
}
