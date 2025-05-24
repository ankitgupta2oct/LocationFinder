//

import SwiftUI

struct MapMarkerView: View {
    var body: some View {
      VStack(spacing: 0) {
        Image(systemName: "map.circle")
        .resizable()
        .scaledToFit()
        .background(.white)
        .frame(width: 45, height: 45)
        .clipShape(.circle)
        
        Image(systemName: "triangle.fill")
          .resizable()
          .scaledToFit()
          .frame(width: 17, height: 17)
          .rotationEffect(.degrees(180))
          .offset(y: -4)
      }
      .foregroundStyle(.red)
      .shadow(radius: 10)
//      .visualEffect({ (content, geomatry) in
//        content
//          .offset(y: -geomatry.size.height / 2)
//      })
    }
}

#Preview {
    MapMarkerView()
}
