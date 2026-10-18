import SwiftUI
import UIKit
import CoreImage.CIFilterBuiltins

struct QRView: View {
    let value: String
    private let context = CIContext()

    var body: some View {
        Group {
            if let image = makeQR(value) {
                Image(uiImage: image)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .accessibilityLabel("QR kode sesi")
            } else {
                Image(systemName: "qrcode")
                    .resizable().scaledToFit().foregroundStyle(.secondary)
                    .accessibilityLabel("QR tidak tersedia")
            }
        }
        .frame(width: 210, height: 210)
        .padding(12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(.black.opacity(0.08)))
    }

    private func makeQR(_ text: String) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(text.utf8)
        filter.correctionLevel = "M"
        guard let output = filter.outputImage else { return nil }
        let scaled = output.transformed(by: CGAffineTransform(scaleX: 12, y: 12))
        guard let cgImage = context.createCGImage(scaled, from: scaled.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
