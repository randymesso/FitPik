import SwiftUI


struct EditUploadView: View {
    let image: UIImage
    var onSave: (ClosetCategory, [String]) -> Void
    var onCancel: () -> Void
    
    @State private var category: ClosetCategory = .top
    @State private var tagText: String = ""
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
                
                HStack {
                    TextField("Add tag (e.g., church)", text: $tagText)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {
                        let t = tagText.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !t.isEmpty else { return }
                        tags.append(t)
                        tagText = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(tags, id: \.self) { t in
                            HStack {
                                Text(t)
                                Button(action: {
                                    tags.removeAll { $0 == t }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                }
                            }
                            .padding(8)
                            .background(Color.secondary.opacity(0.12))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
                
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
