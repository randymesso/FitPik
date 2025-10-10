import SwiftUI


final class ClosetViewModel: ObservableObject {
    @Published private(set) var items: [ClosetItem] = []
    @Published var filterCategory: ClosetCategory? = nil
    @Published var showOnlyRecentSection: Bool = false
    
    init() {
        load()
    }
    
    func load() {
        items = ClosetPersistence.shared.loadItems().sorted(by: { $0.dateAdded > $1.dateAdded })
    }
    
    func addItem(image: UIImage, category: ClosetCategory, tags: [String]) {
        do {
            let fileName = try ClosetPersistence.shared.saveImage(image)
            var item = ClosetItem(fileName: fileName, category: category, tags: tags, dateAdded: Date())
            // insert at front
            items.insert(item, at: 0)
            try ClosetPersistence.shared.saveItems(items)
        } catch {
            print("Error saving item: \(error)")
        }
    }
    
    func updateItem(_ updated: ClosetItem) {
        if let idx = items.firstIndex(where: { $0.id == updated.id }) {
            items[idx] = updated
            try? ClosetPersistence.shared.saveItems(items)
        }
    }
    
    func deleteItem(_ item: ClosetItem) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            let removed = items.remove(at: idx)
            ClosetPersistence.shared.deleteImage(named: removed.fileName)
            try? ClosetPersistence.shared.saveItems(items)
        }
    }
    
    // convenience
    var recentThree: [ClosetItem] {
        Array(items.prefix(3))
    }
    
    var filteredItems: [ClosetItem] {
        guard let cat = filterCategory else { return items }
        return items.filter { $0.category == cat }
    }
}
