import SwiftUI
import MapKit

struct LocationView: View {
  @Environment(LocationViewModel.self) var viewModel: LocationViewModel
  let maxWidthForIPad: CGFloat = 700
  
    var body: some View {
      ZStack {
        mapView
        
        VStack {
          titleView
            .frame(maxWidth: maxWidthForIPad)
            .padding()
          Spacer()
          
          ForEach(viewModel.locations) { location in
            if location == viewModel.location {
              LocationPreviewView(location: location)
                .padding(.horizontal, 5)
                .frame(maxWidth: maxWidthForIPad)
                .frame(maxWidth: .infinity)
                .transition(.asymmetric(
                  insertion: .move(edge: .trailing),
                  removal: .move(edge: .leading)))
            }
          }
        }
      }
      .sheet(item: Binding<Location?>(
        get: { viewModel.locationDetail },
        set: { viewModel.locationDetail = $0 }
      )) { location in
        LocationDetailView(location: location)
      }
    }
}

private extension LocationView {
  private var mapView: some View {
    Map(position: Binding(
      get: { viewModel.position },
      set: { _ in }
    )) {
      ForEach(viewModel.locations) { location in
        Annotation(location.name, coordinate: location.coordinates) {
          MapMarkerView()
            .scaleEffect(viewModel.location == location ? 1.0 : 0.7)
            .onTapGesture {
              viewModel.setLocation(for: location)
            }
        }
      }
    }
    .animation(.smooth, value: viewModel.position)
    .mapControlVisibility(.hidden)
  }
  
  private var titleView: some View {
    VStack {
      Button {
        withAnimation(.easeIn) {
          viewModel.showLocations.toggle()
        }
      } label: {
        Text("\(viewModel.location.name), \(viewModel.location.cityName)")
          .padding()
          .font(.title2)
          .bold()
          .frame(maxWidth: .infinity)
          .foregroundStyle(.primary)
          .overlay(alignment: .leading) {
            Image(systemName: "arrow.down")
              .bold()
              .rotationEffect(viewModel.showLocations ? .degrees(180) : .zero)
              .offset(x: 20)
          }
      }
      .foregroundStyle(.primary)

      if(viewModel.showLocations) {
        LocationListView()
      }
    }
    .frame(maxWidth: .infinity)
    .background(.thinMaterial)
    .clipShape(.rect(cornerRadius: 10))
    .shadow(radius: 20, x: 0, y: 10)
  }
  
}

#Preview {
    LocationView()
      .environment(LocationViewModel())
}
