import SwiftUI


struct ClosetItem: Identifiable, Codable {
    var id: String = UUID().uuidString
    var fileName: String // local image file name in Documents
    var category: ClosetCategory
    var tags: [String]
    var dateAdded: Date = Date()
}
