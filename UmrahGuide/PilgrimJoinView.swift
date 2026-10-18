import SwiftUI

struct PilgrimJoinView: View {
    @EnvironmentObject private var store: SessionStore
    @EnvironmentObject private var app: AppModel
    @State private var code = ""
    @State private var showError = false

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "headphones.circle.fill")
                .font(.system(size: 48)).symbolRenderingMode(.hierarchical)
            Text("Gabung Sesi").font(.title2.bold())
            Text("Masukkan kode yang diberikan pemandu.")
                .foregroundStyle(.secondary).multilineTextAlignment(.center)

            TextField("KODE SESI", text: $code)
                .textInputAutocapitalization(.characters)
                .autocorrectionDisabled()
                .font(.title2.monospaced())
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .onChange(of: code) { newValue in
                    code = String(newValue.uppercased().filter { $0.isLetter || $0.isNumber }.prefix(8))
                    showError = false
                }

            Button {
                showError = !store.join(code: code)
                if !showError { app.scanGuides() }
            } label: {
                Label("Hubungkan", systemImage: "link")
                    .frame(maxWidth: .infinity).padding(.vertical, 5)
            }
            .buttonStyle(.borderedProminent)

            if showError, let message = store.lastError {
                Text(message).foregroundStyle(.red).font(.footnote)
            } else if app.isScanning {
                Text(app.statusMessage)
                    .foregroundStyle(.secondary).font(.footnote)
                    .multilineTextAlignment(.center)
            }

            Label("Mode jamaah hanya untuk mendengarkan.", systemImage: "ear.fill")
                .font(.footnote).foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
