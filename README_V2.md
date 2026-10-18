# Umrah Guide iOS — Prototype V2.1

Paket ini menyiapkan source SwiftUI dan workflow GitHub Actions untuk **validasi kompilasi iOS Simulator tanpa signing**. Build workflow tidak menghasilkan IPA yang dapat dipasang di iPhone.

## Fitur UI prototype
- Pilihan mode Pemandu / Jamaah.
- Pembuatan kode sesi 6 karakter dan QR code.
- Validasi format kode sesi jamaah.
- Pilihan jalur Wi-Fi lokal / internet sebagai UI.
- Status demo siaran dan tombol mengakhiri sesi.
- Model aplikasi dan session store yang dibutuhkan agar project dapat dikompilasi.

## Batasan penting — belum untuk produksi
**Audio real-time belum berfungsi.** Tombol siaran hanya mengubah status UI dan tidak mengirim suara mikrofon. Kode sesi belum didaftarkan ke server, join hanya memvalidasi format, penemuan perangkat Bonjour belum diimplementasikan, pemindaian QR kamera belum dibuat, dan fallback Wi-Fi/internet belum aktif. Lihat `Server/WEBRTC_PRODUCTION_PLAN.md` untuk rancangan backend.

## Build dari Windows melalui GitHub Actions
1. Ekstrak ZIP.
2. Buat repository GitHub baru bernama `Umrah-Guide-iOS`.
3. Upload seluruh isi folder ini ke root repository, termasuk folder `.github` (aktifkan tampilan file tersembunyi bila perlu).
4. Buka tab **Actions** dan izinkan Actions jika diminta.
5. Jalankan workflow **iOS Build (Unsigned Validation)** melalui **Run workflow**, atau push ke branch `main` / `master`.
6. Buka run yang selesai dan unduh artefak `umrah-guide-ios-build-log` untuk memeriksa hasil kompilasi.

Workflow memasang XcodeGen di runner macOS dan menghasilkan `UmrahGuide.xcodeproj` dari `project.yml`. Tidak ada sertifikat atau rahasia Apple yang diperlukan untuk tahap validasi ini.

## Langkah menuju IPA
Setelah build simulator berhasil, ubah Bundle Identifier `com.umrahguide.app` menjadi ID unik milik aplikasi Anda, lalu siapkan signing. Untuk menguji di iPhone sendiri, gunakan Mac dengan Xcode dan Apple Account pada Automatic Signing. Untuk distribusi IPA melalui CI, biasanya diperlukan Apple Developer Program, sertifikat distribusi, provisioning profile, dan penyimpanan rahasia yang aman di GitHub Actions Secrets. Jangan pernah commit sertifikat atau private key ke repository.

## File proyek
- `project.yml`: definisi proyek Xcode untuk XcodeGen.
- `.github/workflows/build-ios.yml`: workflow validasi build simulator.
- `UmrahGuide/`: source SwiftUI.
- `Server/`: catatan dependensi dan rancangan backend audio produksi.
