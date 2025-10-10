import SwiftUI


struct GridCell: View {
    let item: ClosetItem
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let ui = ClosetPersistence.shared.loadImage(named: item.fileName) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.12))
                    .frame(height: 120)
                    .cornerRadius(8)
            }
            Text(item.category.rawValue)
                .font(.caption2).bold()
                .padding(6)
                .background(item.category.color.opacity(0.9))
                .foregroundColor(.white)
                .cornerRadius(6)
                .padding(8)
        }
    }
}
