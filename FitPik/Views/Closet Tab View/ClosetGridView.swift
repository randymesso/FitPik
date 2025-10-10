import SwiftUI


struct ClosetGridView: View {
    let items: [ClosetItem]
    var onTap: (ClosetItem) -> Void
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(items) { item in
                    GridCell(item: item)
                        .onTapGesture {
                            onTap(item)
                        }
                }
            }
        }
    }
}
