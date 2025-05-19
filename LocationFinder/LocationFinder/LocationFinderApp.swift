//

import SwiftUI

@main
struct LocationFinderApp: App {
  @State var viewModel = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView()
            .environment(viewModel)
        }
    }
}
