import SwiftUI


enum ClosetCategory: String, CaseIterable, Codable, Identifiable {
    case top = "Top"
    case bottom = "Bottom"
    case dress = "Dress"
    case shoes = "Shoes"
    
    var id: String { rawValue }
    var color: Color {
        switch self {
            case .top: return .blue
            case .bottom: return .green
            case .dress: return .purple
            case .shoes: return .orange
        }
    }
}
