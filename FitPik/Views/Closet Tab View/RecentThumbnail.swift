import SwiftUI


struct RecentThumbnail: View {
    let item: ClosetItem
    var body: some View {
        VStack {
            if let ui = ClosetPersistence.shared.loadImage(named: item.fileName) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 140)
                    .clipped()
                    .cornerRadius(8)
                    .overlay(alignment: .topLeading) {
                        Text(item.category.rawValue)
                            .font(.caption2).bold()
                            .padding(6)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                            .padding(6)
                    }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 100, height: 140)
                    .cornerRadius(8)
                    .overlay(Text("No image").font(.caption))
            }
        }
    }
}
