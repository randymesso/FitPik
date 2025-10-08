import SwiftUI


struct TodayOutfitCard: View {
  let title: String
  let reason: String
  let confidence: Double
  @Binding var refreshing: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text("Today’s Outfit")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Text(title)
            .font(.title3)
            .bold()
        }
        Spacer()
        HStack(spacing: 8) {
          Text("\(Int(confidence * 100))%")
            .font(.subheadline).bold()
          Image(systemName: "shield.lefthalf.fill") // small icon for confidence
        }
      }
      
      Text(reason)
        .font(.footnote)
        .foregroundColor(.secondary)
      
      HStack {
        Button(action: {
          // apply outfit / open builder
        }) {
          Label("Wear Now", systemImage: "checkmark.seal.fill")
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.accentColor, lineWidth: 1))
        }
        
        Button(action: {
          // save to favorites
        }) {
          Label("Save", systemImage: "heart")
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor.opacity(0.12)))
        }
        
        Spacer()
        
        if refreshing {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
        } else {
          Button(action: {
            // lightweight local refresh tap — this could call a callback instead
            // in this example, no direct access to refresh function; keep this UI element for future wiring
          }) {
            Image(systemName: "arrow.clockwise")
          }
        }
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 14)
        .fill(Color(UIColor.secondarySystemBackground))
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 4)
    )
  }
}
