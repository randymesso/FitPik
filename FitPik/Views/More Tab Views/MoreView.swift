import SwiftUI


struct MoreView: View {
  var body: some View {
    List {
      NavigationLink(destination: Text("AI Chat Placeholder")) {
        Label("AI Chat", systemImage: "message")
      }
      NavigationLink(destination: Text("Inspiration Board Placeholder")) {
        Label("Inspiration Board", systemImage: "photo.on.rectangle")
      }
      NavigationLink(destination: Text("Settings Placeholder")) {
        Label("Settings", systemImage: "gearshape")
      }
    }
    .navigationTitle("More")
  }
}
