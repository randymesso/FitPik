import SwiftUI


struct ClosetView: View {
  @EnvironmentObject var appState: AppState
  var body: some View {
    VStack {
      Text("Closet")
        .font(.title2).bold()
        .padding(.top)
      Text("Your uploaded items will appear here.")
        .foregroundColor(.secondary)
        .padding()
      Spacer()
    }
    .navigationTitle("Closet")
  }
}
