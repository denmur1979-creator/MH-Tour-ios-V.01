import SwiftUI

@main
struct UmrahGuideApp: App {
    @StateObject private var appModel = AppModel()
    @StateObject private var sessionStore = SessionStore()

    var body: some Scene {
        WindowGroup {
            RootV2View()
                .environmentObject(appModel)
                .environmentObject(sessionStore)
        }
    }
}
