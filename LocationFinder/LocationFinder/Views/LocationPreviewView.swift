//

import SwiftUI

struct LocationPreviewView: View {
  @Environment(LocationViewModel.self) var viewModel
  let location: Location
  
    var body: some View {
      HStack(alignment: .bottom) {
        VStack(alignment: .leading) {
          imageSection
            .padding(.bottom)
          
          Text(location.name)
            .font(.title2)
            .bold()
          
          Text(location.cityName)
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        
        Spacer()
        
        VStack {
          learnMoreButton
          nextButton
        }
      }
      .padding()
      .background {
        RoundedRectangle(cornerRadius: 10)
          .fill(.ultraThinMaterial)
          .offset(y: 65)
          .clipShape(.rect(cornerRadius: 10))
      }
    }
}

extension LocationPreviewView {
  private var imageSection: some View {
    ZStack {
      if let image = location.imageNames.first {
        Image(image)
          .resizable()
          .scaledToFit()
          .frame(width: 150, height: 150)
          .clipShape(.rect(cornerRadius: 10))
      }
    }
    .padding(5)
    .background(.white)
    .clipShape(.rect(cornerRadius: 10))
  }
  
  private var learnMoreButton: some View {
    Button(action: {
      viewModel.locationDetail = location
    }, label: {
      Text("Learn More")
        .frame(width: 125, height: 35)
    })
    .buttonStyle(.borderedProminent)
  }
  
  private var nextButton: some View {
    Button(action: {
      viewModel.setNextLocation()
    }, label: {
      Text("Next")
        .frame(width: 125, height: 35)
    })
    .buttonStyle(.bordered)
  }
}

#Preview {
  LocationPreviewView(location: LocationsDataService.locations.first!)
    .environment(LocationViewModel())
}
