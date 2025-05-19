import SwiftUI

struct LocationView: View {
  @Environment(LocationViewModel.self) var viewModel: LocationViewModel
    var body: some View {
      List {
        ForEach(viewModel.locations) { location in
          Text(location.name)
        }
      }
      .listStyle(.plain)
    }
}

#Preview {
  let viewModel = LocationViewModel()
    LocationView()
      .environment(viewModel)
}
