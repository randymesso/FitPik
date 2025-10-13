import SwiftUI


struct TagSelectionView: View {
    @ObservedObject var tagStore: TagStore = .shared

    // selected tags (binding to parent)
    @Binding var selectedTags: [String]

    // UI state
    @State private var newTagText: String = ""
    @State private var showAddAlert: Bool = false

    // layout
    private let columns = [GridItem(.adaptive(minimum: 100), spacing: 8)]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // quick helper text
            Text("Select occasions (tap to toggle). You can add your own tag below.")
                .font(.footnote)
                .foregroundColor(.secondary)

            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                    ForEach(tagStore.allTags, id: \.self) { tag in
                        TagChip(title: tag, isSelected: selectedTags.contains(tag)) {
                            toggle(tag: tag)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
            .frame(minHeight: 80, maxHeight: 220)

            HStack {
                TextField("Add custom tag", text: $newTagText)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .submitLabel(.done)
                    .onSubmit {
                        addCustom()
                    }

                Button(action: addCustom) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .disabled(newTagText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .alert("Tag exists", isPresented: $showAddAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("That tag already exists in your tags.")
        }
    }

    private func toggle(tag: String) {
        if let i = selectedTags.firstIndex(where: { $0.caseInsensitiveCompare(tag) == .orderedSame }) {
            selectedTags.remove(at: i)
        } else {
            selectedTags.append(tag)
        }
    }

    private func addCustom() {
        let trimmed = newTagText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        // try add to store; if duplicate, still allow selecting existing tag
        let added = tagStore.addCustomTag(trimmed)
        if !added {
            // existing tag — show alert but still toggle selection
            showAddAlert = true
        }
        // ensure the tag exists in store then select it
        if !tagStore.allTags.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) {
            // if add failed weirdly, bail
            newTagText = ""
            return
        }
        // select the tag if not already selected
        if !selectedTags.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) {
            selectedTags.append(trimmed)
        }
        newTagText = ""
    }
}
