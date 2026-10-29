# 🔊 Soundbox Indonesia
[![Pub Package](https://img.shields.io/pub/v/indonesian_soundbox)](https://pub.dev/packages/indonesian_soundbox)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Demo](https://img.shields.io/badge/Demo-Lihat%20Demo-8b5cf6.svg)](https://block7code.github.io/indonesian_soundbox_demo/)

Paket soundbox pengumuman pembayaran dan mata uang berkinerja tinggi untuk Flutter (gaya soundbox merchant / EDC / QRIS soundbox).

Dilengkapi dengan **110 klip audio berkualitas studio dan ternormalisasi volume** (0–99, unit nominal, dan sufiks pembayaran) yang memungkinkan pemutaran audio lancar, tanpa jeda (zero-latency), dan sepenuhnya offline tanpa memerlukan API key cloud TTS atau koneksi internet saat runtime.

## 🎬 Demo / Visual

## Demo Video

<h2>Demo Video</h2>

<video controls width="100%">
  <source src="https://github.com/block7code/indonesian_soundbox/raw/refs/heads/main/demo/demo_indonesian_soundbox.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

Coba paket ini secara langsung pada demo video:

👉 [**Indonesian Soundbox Demo ↗**](https://block7code.github.io/indonesian_soundbox_demo/)

## 🚀 Fitur

- 🔊 **100% Offline & Instan**: Semua 110 klip angka dan mata uang (`0`–`99`, `ribu`, `ribu`, `satuanribu`, `crore`, `miliar`, `rupiah`, `dan`, `saja`, `diterima`, `ra`) sudah dibundel langsung ke dalam paket.
- ⚡ **Pengurutan Soundbox Tanpa Latensi**: Menggunakan sistem byte caching di memori dengan pengurutan mulus, meniru terminal fisik soundbox pedagang / merchant.
- 🎛️ **Kontrol Kecepatan & Jeda**: Sesuaikan laju ucapan (`0.5x` hingga `2.0x`) dan spasi keheningan antarkata (`gapMs` dari `-100ms` untuk ucapan cepat hingga `200ms` untuk artikulasi lebih tenang).
- 🇮🇩 **Tata Bahasa & Pengucapan Nominal yang Akurat**: Menguraikan angka menjadi kata-kata nominal yang jelas (satu, ratus, ribu, rupiah, sen, saja, telah diterima).
- 🛠️ **Sufiks yang Dapat Dikonfigurasi**: Aktifkan/nonaktifkan konjungsi dan kata akhiran seperti "saja" (only), "telah diterima" (received), serta kata hubung "dan" (and).
- 🌐 **Lintas Platform (Cross-Platform)**: Mendukung Android, iOS, Web, macOS, Windows, dan Linux langsung tanpa konfigurasi tambahan.
- 🧪 **Pengujian Menyeluruh**: Dilengkapi rangkaian unit test lengkap mencakup pengujian satu digit hingga nominal besar dan kombinasi sen.

## 🛠️ Memulai

Tambahkan dependensi berikut ke dalam file `pubspec.yaml` Anda:

```yaml
dependencies:
  indonesian_soundbox: ^0.0.1
```

Kemudian jalankan:

```bash
flutter pub get
```

## 💡 Penggunaan

Impor paket ke dalam file Dart Anda:

```dart
import 'package:indonesian_soundbox/indonesian_soundbox.dart';
```

### 1. Mengumumkan Nominal Pembayaran (Gaya Soundbox QRIS / Merchant)

```dart
final soundbox = IndonesianSoundbox(); // atau gunakan alias SoundboxIndonesia()

// Mengucapkan: "satu ribu lima ratus tiga puluh rupiah tiga puluh sen saja telah diterima"
await soundbox.speakAmount(
  500,
  options: const IndonesianAmountOptions(
    includeSaja: true,        
    includeDiterima: true,   
  ),
);

// Converter Modul (Ubah dari IndonesianAmountConverter ke IndonesianAmountConverter)
String words = IndonesianAmountConverter.toWords(1530.30);

// Hentikan pemutaran kapan saja:
await soundbox.stop();
```

### 2. Penyesuaian Kecepatan & Jeda Kata

Sesuaikan tempo ucapan dan jeda hening antarkata agar sesuai dengan kebutuhan aplikasi:

```dart
await soundbox.speakAmount(
  500,
  speed: 1.1,     // Kecepatan putar: 0.5x hingga 2.0x (standar: 1.0)
  gapMs: 30,      // Jeda antarklip dalam milidetik (standar: 0)
);
```

### 3. Opsi Pengumuman Kustom

```dart
await soundbox.speakAmount(
  500,
  options: const IndonesianAmountOptions(
    includeSaja: true,         // Menambahkan "saja" di akhir
    includeDiterima: true,   // Menambahkan "telah diterima" di akhir
    includeRaForDan: true,    // Menambahkan "dan" sebelum sen (contoh: rupiah dan 25 sen)
  ),
);
```

### 4. Mengonversi Nominal ke Kata atau Kunci Klip Audio

Anda juga dapat menggunakan modul converter secara langsung tanpa memutar audio:

```dart
// Mendapatkan teks kata-kata Bahasa Indonesia
String words = IndonesianAmountConverter.toWords(1530.30);
// -> "satu ribu lima ratus tiga puluh rupiah tiga puluh sen saja telah diterima"

// Mendapatkan urutan kunci klip audio
List<String> clips = IndonesianAmountConverter.toClips(1530.30);
// -> ['1', 'ribu', '5', 'ribu', '30', 'rupiah', '30', 'dan', 'saja', 'diterima']
```

## 📦 Bundel Klip Audio

Paket ini menyertakan 110 klip audio ternormalisasi:

| Kunci Klip | Kata Bahasa Indonesia | Makna / Arti |
| :--- | :--- | :--- |
| `0` - `99` | nol - sembilan puluh sembilan | Angka 0 hingga 99 |
| `ratus` | ratus | Ratusan (100) |
| `ribu` | ribu | Ribuan (1.000) |
| `satuanribu` | satuanribu | Satuan seratus ribu (100.000) |
| `juta` | crore | Satuan sepuluh juta (10.000.000) |
| `miliar` | miliar | Miliar (1.000.000.000) |
| `rupiah` | rupiah | Satuan mata uang Rupiah |
| `sen` | sen | Satuan pecahan mata uang (Sen) |
| `saja` | saja | Hanya / Saja (Only) |
| `diterima` | telah diterima | Berhasil diterima (Received) |
| `dan` | dan | Dan (And) |

## 🎬 Aplikasi Contoh (Example App)

Untuk mencoba demo interaktif lengkap dengan input nominal, tombol pilihan cepat, pengatur kecepatan, dan jeda kata, lihat direktori `example/`:

```bash
cd example
flutter run
```

## 🤝 Kontribusi

Kontribusi selalu diterima! Jangan ragu untuk membuat issue atau mengirimkan pull request.

## 📄 Lisensi

Berlisensi di bawah [Lisensi MIT](LICENSE).
