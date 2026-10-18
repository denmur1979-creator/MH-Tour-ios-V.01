import Foundation
import Combine

@MainActor
final class SessionStore: ObservableObject {
    @Published var session: UmrahSession?
    @Published var joinCode = ""
    @Published var route: ConnectionRoute = .wifi
    @Published var lastError: String?

    func createSession(guideName: String) {
        let code = String((0..<6).compactMap { _ in "0123456789ABCDEFGHJKLMNPQRSTUVWXYZ".randomElement() })
        session = UmrahSession(
            id: UUID().uuidString,
            name: "Umrah Guide",
            guideName: guideName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Guide" : guideName.trimmingCharacters(in: .whitespacesAndNewlines),
            joinCode: code,
            createdAt: .now
        )
        lastError = nil
    }

    /// Validates the format only. A real server must authenticate and resolve this code.
    func join(code: String) -> Bool {
        let clean = code.uppercased().filter { $0.isLetter || $0.isNumber }
        guard (4...8).contains(clean.count) else {
            lastError = "Masukkan kode sesi 4–8 karakter."
            return false
        }
        joinCode = clean
        lastError = nil
        return true
    }

    func endSession() {
        session = nil
        joinCode = ""
        lastError = nil
    }
}
