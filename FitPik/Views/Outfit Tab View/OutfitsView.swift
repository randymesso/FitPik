import SwiftUI


struct OutfitsView: View {
  var body: some View {
    VStack {
      Text("Outfits")
        .font(.title2).bold()
        .padding(.top)
      Text("Build & save outfits here.")
        .foregroundColor(.secondary)
        .padding()
      Spacer()
    }
    .navigationTitle("Outfits")
  }
}
