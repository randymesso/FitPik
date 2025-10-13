import SwiftUI


struct ClosetItemDetailView: View {
    @State var item: ClosetItem
    var onSave: (ClosetItem) -> Void
    var onDelete: (ClosetItem) -> Void
    @Environment(\.presentationMode) var presentation

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                if let ui = ClosetPersistence.shared.loadImage(named: item.fileName) {
                    Image(uiImage: ui)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 420)
                        .cornerRadius(12)
                        .padding()
                } else {
                    Rectangle().fill(Color.gray.opacity(0.12)).frame(height: 260)
                }

                Picker("Category", selection: $item.category) {
                    ForEach(ClosetCategory.allCases) { c in
                        Text(c.rawValue).tag(c)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // TagSelectionView - bind to item's tags
                TagSelectionView(selectedTags: $item.tags)
                    .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { presentation.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Delete", role: .destructive) {
                            onDelete(item)
                        }
                        Button("Save") {
                            onSave(item)
                            presentation.wrappedValue.dismiss()
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}
