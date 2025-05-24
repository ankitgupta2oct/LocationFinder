import SwiftUI
import MapKit

struct LocationView: View {
  @Environment(LocationViewModel.self) var viewModel: LocationViewModel
  
    var body: some View {
      ZStack {
        mapView
        
        VStack {
          titleView
            .padding()
          Spacer()
          
          ForEach(viewModel.locations) { location in
            if location == viewModel.location {
              LocationPreviewView(location: location)
                .padding(.horizontal, 5)
                .transition(.asymmetric(
                  insertion: .move(edge: .trailing),
                  removal: .move(edge: .leading)))
            }
          }
        }
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
          .overlay(alignment: .leading) {
            Image(systemName: "arrow.down")
              .bold()
              .rotationEffect(viewModel.showLocations ? .degrees(180) : .zero)
              .offset(x: 20)
          }
      }
      .foregroundStyle(.black)

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
