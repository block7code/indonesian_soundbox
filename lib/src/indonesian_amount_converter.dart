import 'indonesian_words.dart';

/// Opsi konfigurasi untuk mengonversi jumlah pembayaran menjadi teks kata atau klip audio.
class IndonesianAmountOptions {
  /// Apakah menambahkan 'saja' di akhir pengumuman jumlah.
  final bool includeSaja;

  /// Apakah menambahkan 'telah diterima' di akhir pengumuman jumlah.
  final bool includeDiterima;

  /// Opsi ini dipertahankan untuk kompatibilitas API.
  /// Karena pecahan desimal tidak lagi diucapkan, opsi ini tidak berpengaruh
  /// pada hasil keluaran.
  final bool includeDanForSen;

  /// Membuat konfigurasi [IndonesianAmountOptions].
  const IndonesianAmountOptions({
    this.includeSaja = true,
    this.includeDiterima = true,
    this.includeDanForSen = false,
  });
}

/// Alias untuk kompatibilitas mundur.
@Deprecated('Gunakan IndonesianAmountOptions')
typedef IndoAmountOptions = IndonesianAmountOptions;

/// Pecahan desimal di-*floor* (dipotong, bukan dibulatkan) dan tidak diucapkan.
/// Kata "sen" / "paisa" tidak pernah muncul dalam hasil.
abstract final class IndonesianAmountConverter {
  IndonesianAmountConverter._();

  // ---------------------------------------------------------------------------
  // Fungsi publik
  // ---------------------------------------------------------------------------

  /// Mengonversi jumlah (misalnya `1530.30`) menjadi daftar kunci klip audio
  /// yang berurutan sesuai sistem bilangan Indonesia.
  ///
  /// Pecahan desimal dipotong (floor) dan tidak diucapkan.
  static List<String> toClips(
    num amount, {
    IndonesianAmountOptions options = const IndonesianAmountOptions(),
  }) {
    // Floor terhadap nilai absolut — pecahan desimal dibuang.
    final int rupiah = amount.toDouble().abs().floor();

    final List<String> clips = [];

    if (rupiah > 0) {
      clips.addAll(_integerToClips(rupiah));
    } else {
      clips.add("0");
    }

    clips.add("rupiah");

    if (options.includeSaja) {
      clips.add("saja");
    }

    if (options.includeDiterima) {
      clips.add("diterima");
    }

    return clips;
  }

  /// Mengonversi jumlah (misalnya `1530.30`) menjadi teks ucapan Bahasa Indonesia.
  ///
  /// Pecahan desimal dipotong (floor) dan tidak diucapkan.
  static String toWords(
    num amount, {
    IndonesianAmountOptions options = const IndonesianAmountOptions(),
  }) {
    // Floor terhadap nilai absolut — pecahan desimal dibuang.
    final int rupiah = amount.toDouble().abs().floor();

    final List<String> words = [];

    if (rupiah > 0) {
      words.addAll(_integerToWords(rupiah));
    } else {
      words.add(indonesianNumbers0To99[0]);
    }

    words.add(indonesianExtraWords["rupiah"]!);

    if (options.includeSaja) {
      words.add(indonesianExtraWords["saja"]!);
    }

    if (options.includeDiterima) {
      words.add(indonesianExtraWords["diterima"]!);
    }

    return words.join(" ");
  }

  // ---------------------------------------------------------------------------
  // Helper privat — Sistem bilangan Indonesia
  // ---------------------------------------------------------------------------

  /// Mengonversi bilangan bulat positif menjadi daftar kunci klip audio.

  static List<String> _integerToClips(int number) {
    if (number <= 0) return [];
    if (number < 100) return [number.toString()];

    final List<String> result = [];
    int rem = number;

    // Miliar (×1.000.000.000)
    if (rem >= 1000000000) {
      final int miliar = rem ~/ 1000000000;
      result.addAll(_integerToClips(miliar));
      result.add("miliar");
      rem %= 1000000000;
    }

    // Juta (×1.000.000)
    if (rem >= 1000000) {
      final int juta = rem ~/ 1000000;
      result.addAll(_integerToClips(juta));
      result.add("juta");
      rem %= 1000000;
    }

    // Ribu (×1.000)
    if (rem >= 1000) {
      final int ribu = rem ~/ 1000;
      if (ribu == 1) {
        result.add("se");
      } else {
        result.addAll(_integerToClips(ribu));
      }
      result.add("ribu");
      rem %= 1000;
    }

    // Ratus (×100)
    if (rem >= 100) {
      final int ratus = rem ~/ 100;
      if (ratus == 1) {
        result.add("se");
      } else {
        result.addAll(_integerToClips(ratus));
      }
      result.add("ratus");
      rem %= 100;
    }

    // Sisa 1–99
    if (rem > 0) {
      result.add(rem.toString());
    }

    return result;
  }

  /// Mengonversi bilangan bulat positif menjadi daftar kata Bahasa Indonesia.
  ///
  /// Menggunakan sistem bilangan Indonesia standar:
  ///   miliar (×1.000.000.000)
  ///   juta   (×1.000.000)
  ///   ribu   (×1.000)
  ///   ratus  (×100)
  ///   1–99   → langsung dari tabel kata
  static List<String> _integerToWords(int number) {
    if (number <= 0) return [];
    if (number < 100) return [indonesianNumbers0To99[number]];

    final List<String> result = [];
    int rem = number;

    // Miliar (×1.000.000.000)
    if (rem >= 1000000000) {
      final int miliar = rem ~/ 1000000000;
      result.addAll(_integerToWords(miliar));
      result.add(indonesianExtraWords["miliar"]!);
      rem %= 1000000000;
    }

    // Juta (×1.000.000)
    if (rem >= 1000000) {
      final int juta = rem ~/ 1000000;
      result.addAll(_integerToWords(juta));
      result.add(indonesianExtraWords["juta"]!);
      rem %= 1000000;
    }

    // Ribu (×1.000)
    if (rem >= 1000) {
      final int ribu = rem ~/ 1000;
      result.addAll(_integerToWords(ribu));
      result.add(indonesianExtraWords["ribu"]!);
      rem %= 1000;
    }

    // Ratus (×100)
    if (rem >= 100) {
      final int ratus = rem ~/ 100;
      result.addAll(_integerToWords(ratus));
      result.add(indonesianExtraWords["ratus"]!);
      rem %= 100;
    }

    // Sisa 1–99
    if (rem > 0) {
      result.add(indonesianNumbers0To99[rem]);
    }

    return result;
  }
}

/// Alias untuk kompatibilitas mundur.
@Deprecated('Gunakan IndonesianAmountConverter')
typedef IndoAmountConverter = IndonesianAmountConverter;
