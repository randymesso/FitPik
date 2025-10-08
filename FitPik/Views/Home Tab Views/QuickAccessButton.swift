import SwiftUI


struct QuickAccessButton: View {
  let title: String
  let systemImage: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack(spacing: 12) {
        Image(systemName: systemImage)
          .font(.title2)
          .frame(width: 36, height: 36)
          .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor.systemBackground)))
          .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(UIColor.separator)))
        Text(title)
          .font(.headline)
        Spacer()
      }
      .padding()
      .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.secondarySystemBackground)))
    }
  }
}
