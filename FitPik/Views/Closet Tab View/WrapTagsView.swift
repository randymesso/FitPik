import SwiftUI


struct WrapTagsView: View {
    let tags: [String]
    var onRemove: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { t in
                    HStack {
                        Text(t)
                        Button(action: { onRemove(t) }) {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                    .padding(8)
                    .background(Color.secondary.opacity(0.12))
                    .cornerRadius(12)
                }
            }
        }
    }
}
