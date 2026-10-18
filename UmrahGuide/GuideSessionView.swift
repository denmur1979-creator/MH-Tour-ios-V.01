import SwiftUI

struct GuideSessionView: View {
    @EnvironmentObject private var store: SessionStore
    @EnvironmentObject private var app: AppModel
    @State private var guideName = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                Text("Sesi Pemandu").font(.title2.bold())

                if let session = store.session {
                    QRView(value: session.joinCode)
                    Text(session.joinCode)
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .tracking(4)
                        .accessibilityLabel("Kode sesi \(session.joinCode)")
                    Text("Tunjukkan QR atau kode ini kepada jamaah.")
                        .font(.subheadline).foregroundStyle(.secondary)

                    HStack {
                        Label("Jalur koneksi", systemImage: "point.3.connected.trianglepath.dotted")
                        Spacer()
                        Picker("Jalur", selection: $store.route) {
                            ForEach(ConnectionRoute.allCases) { route in
                                Text(route.rawValue).tag(route)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                    Button {
                        app.startGuide()
                    } label: {
                        Label(app.isBroadcasting ? "Siaran Demo Aktif" : "Mulai Siaran Demo",
                              systemImage: app.isBroadcasting ? "dot.radiowaves.left.and.right" : "mic.fill")
                            .frame(maxWidth: .infinity).padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(app.isBroadcasting)

                    Text(app.statusMessage)
                        .font(.footnote).foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    if app.isBroadcasting {
                        Button("Berhenti Siaran", role: .destructive) { app.stopGuide() }
                    }
                    Button("Akhiri Sesi", role: .destructive) {
                        app.stopGuide()
                        store.endSession()
                    }
                    .padding(.top, 4)
                } else {
                    TextField("Nama pemandu", text: $guideName)
                        .textContentType(.name)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        store.createSession(guideName: guideName)
                    } label: {
                        Label("Buat Sesi", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity).padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
    }
}
