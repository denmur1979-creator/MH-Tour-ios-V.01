import Foundation

struct UmrahSession: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let guideName: String
    let joinCode: String
    let createdAt: Date
}

enum ConnectionRoute: String, CaseIterable, Identifiable {
    case wifi = "Wi‑Fi Lokal"
    case internet = "Internet"
    var id: String { rawValue }
}
