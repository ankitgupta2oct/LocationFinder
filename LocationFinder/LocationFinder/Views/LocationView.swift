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
        }
      }
    }
}

private extension LocationView {
  private var mapView: some View {
    Map(position: Binding(
      get: { viewModel.position },
      set: { _ in }
    ))
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
