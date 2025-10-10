import SwiftUI


// MARK: - Persistence (simple file-based)

final class ClosetPersistence {
    static let shared = ClosetPersistence()
    private init() {}
    
    private let jsonFile = "closet_items.json"
    
    // Documents directory URL
    private var docsURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var jsonURL: URL {
        docsURL.appendingPathComponent(jsonFile)
    }
    
    func saveImage(_ image: UIImage) throws -> String {
        let id = UUID().uuidString
        let fileName = "\(id).jpg"
        let url = docsURL.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "ClosetPersistence", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to encode image"])
        }
        try data.write(to: url, options: [.atomic])
        return fileName
    }
    
    func loadImage(named fileName: String) -> UIImage? {
        let url = docsURL.appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
    
    func deleteImage(named fileName: String) {
        let url = docsURL.appendingPathComponent(fileName)
        try? FileManager.default.removeItem(at: url)
    }
    
    func saveItems(_ items: [ClosetItem]) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(items)
        try data.write(to: jsonURL, options: [.atomic])
    }
    
    func loadItems() -> [ClosetItem] {
        guard FileManager.default.fileExists(atPath: jsonURL.path),
              let data = try? Data(contentsOf: jsonURL)
        else { return [] }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return (try? decoder.decode([ClosetItem].self, from: data)) ?? []
    }
}
