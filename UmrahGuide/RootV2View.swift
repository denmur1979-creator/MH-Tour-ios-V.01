import SwiftUI

struct RootV2View: View {
    @EnvironmentObject private var app: AppModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 8) {
                    Image(systemName: "headphones.circle.fill")
                        .font(.system(size: 64))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.tint)
                    Text("UMRAH GUIDE").font(.largeTitle.bold())
                    Text("Audio panduan untuk perjalanan umrah")
                        .font(.subheadline).foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 8)

                Picker("Mode", selection: $app.mode) {
                    ForEach(AppMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .accessibilityLabel("Pilih mode aplikasi")

                Group {
                    if app.mode == .guide {
                        GuideSessionView()
                    } else {
                        PilgrimJoinView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Text("Prototype — audio real-time belum diaktifkan")
                    .font(.caption2).foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .navigationTitle("Umrah Guide")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
