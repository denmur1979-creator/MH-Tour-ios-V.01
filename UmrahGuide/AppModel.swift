import Foundation
import Combine

/// State model for the prototype UI. Audio transport is intentionally not
/// represented as connected until a real local/WebRTC transport is integrated.
@MainActor
final class AppModel: ObservableObject {
    @Published var mode: AppMode = .guide
    @Published private(set) var isBroadcasting = false
    @Published private(set) var isScanning = false
    @Published private(set) var connectedClients = 0
    @Published private(set) var statusMessage = "Siap membuat atau bergabung ke sesi"

    func startGuide() {
        // UI prototype only: this does not transmit microphone audio yet.
        isBroadcasting = true
        statusMessage = "Siaran demo aktif — audio belum terhubung ke server"
    }

    func stopGuide() {
        isBroadcasting = false
        connectedClients = 0
        statusMessage = "Siaran dihentikan"
    }

    func scanGuides() {
        // Discovery via Bonjour / local network is not implemented in this prototype.
        isScanning = true
        statusMessage = "Kode diterima. Penemuan guide memerlukan layanan jaringan."
    }

    func stopScanning() {
        isScanning = false
    }
}

enum AppMode: String, CaseIterable, Identifiable {
    case guide = "Pemandu"
    case pilgrim = "Jamaah"

    var id: String { rawValue }
}
