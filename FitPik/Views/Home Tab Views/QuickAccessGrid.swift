import SwiftUI


struct QuickAccessGrid<Content: View>: View {
  var content: () -> Content
  
  init(@ViewBuilder content: @escaping () -> Content = { EmptyView() }) {
    self.content = content
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Quick Access")
        .font(.headline)
      LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
        QuickAccessButton(title: "AI Chat", systemImage: "message.fill") {
          // action
        }
        QuickAccessButton(title: "My Closet", systemImage: "tshirt.fill") {
          // action: switch to closet tab or navigate
        }
        QuickAccessButton(title: "Inspo Board", systemImage: "photo.on.rectangle.angled") {
          // action
        }
        QuickAccessButton(title: "Calendar", systemImage: "calendar") {
          // action
        }
      }
    }
  }
}
