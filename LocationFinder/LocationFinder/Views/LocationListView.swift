//

import SwiftUI

struct LocationListView: View {
  @Environment(LocationViewModel.self) var viewModel
  
    var body: some View {
      List {
        ForEach(viewModel.locations.filter { $0.id != viewModel.location.id }) { location in
          Button(action: {
            viewModel.setLocation(for: location)
            viewModel.showLocations = false
          }, label: {
            listRowView(location: location)
          })
            .listRowBackground(Color.clear)
        }
      }
      .listStyle(.plain)
    }
}

extension LocationListView {
  func listRowView(location: Location) -> some View {
    HStack {
      if let image = location.imageNames.first {
        Image(image)
          .resizable()
          .frame(width: 45, height: 45)
        VStack(alignment: .leading) {
          Text(location.name)
            .font(.headline)
            .bold()
          Text(location.cityName)
            .font(.subheadline)
        }
      }
    }
  }
}

#Preview {
    LocationListView()
      .environment(LocationViewModel())
}
