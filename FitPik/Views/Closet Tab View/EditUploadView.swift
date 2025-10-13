import SwiftUI


struct EditUploadView: View {
    let image: UIImage
    var onSave: (ClosetCategory, [String]) -> Void
    var onCancel: () -> Void
    
    @State private var category: ClosetCategory = .top
    @State private var tags: [String] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 320)
                    .cornerRadius(12)
                    .padding()
                
                Picker("Category", selection: $category) {
                    ForEach(ClosetCategory.allCases) { c in
                        Text(c.rawValue).tag(c)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Tag selection UI
                TagSelectionView(selectedTags: $tags)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Tag & Save")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { onCancel() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(category, tags)
                    }
                    .disabled(false)
                }
            }
        }
    }
}
