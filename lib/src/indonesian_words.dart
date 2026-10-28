// Kosakata Bahasa Indonesia untuk angka, satuan, dan istilah pembayaran.

/// Daftar kata untuk angka 0 sampai 99 dalam Bahasa Indonesia.
const List<String> indonesianNumbers0To99 = [
  "nol", "satu", "dua", "tiga", "empat", "lima", "enam", "tujuh", "delapan",
  "sembilan", // 0-9
  "sepuluh", "sebelas", "dua belas", "tiga belas", "empat belas", "lima belas",
  "enam belas", "tujuh belas", "delapan belas", "sembilan belas", // 10-19
  "dua puluh",
  "dua puluh satu",
  "dua puluh dua",
  "dua puluh tiga",
  "dua puluh empat",
  "dua puluh lima",
  "dua puluh enam",
  "dua puluh tujuh",
  "dua puluh delapan",
  "dua puluh sembilan", // 20-29
  "tiga puluh",
  "tiga puluh satu",
  "tiga puluh dua",
  "tiga puluh tiga",
  "tiga puluh empat",
  "tiga puluh lima",
  "tiga puluh enam",
  "tiga puluh tujuh",
  "tiga puluh delapan",
  "tiga puluh sembilan", // 30-39
  "empat puluh",
  "empat puluh satu",
  "empat puluh dua",
  "empat puluh tiga",
  "empat puluh empat",
  "empat puluh lima",
  "empat puluh enam",
  "empat puluh tujuh",
  "empat puluh delapan",
  "empat puluh sembilan", // 40-49
  "lima puluh",
  "lima puluh satu",
  "lima puluh dua",
  "lima puluh tiga",
  "lima puluh empat",
  "lima puluh lima",
  "lima puluh enam",
  "lima puluh tujuh",
  "lima puluh delapan",
  "lima puluh sembilan", // 50-59
  "enam puluh",
  "enam puluh satu",
  "enam puluh dua",
  "enam puluh tiga",
  "enam puluh empat",
  "enam puluh lima",
  "enam puluh enam",
  "enam puluh tujuh",
  "enam puluh delapan",
  "enam puluh sembilan", // 60-69
  "tujuh puluh",
  "tujuh puluh satu",
  "tujuh puluh dua",
  "tujuh puluh tiga",
  "tujuh puluh empat",
  "tujuh puluh lima",
  "tujuh puluh enam",
  "tujuh puluh tujuh",
  "tujuh puluh delapan",
  "tujuh puluh sembilan", // 70-79
  "delapan puluh",
  "delapan puluh satu",
  "delapan puluh dua",
  "delapan puluh tiga",
  "delapan puluh empat",
  "delapan puluh lima",
  "delapan puluh enam",
  "delapan puluh tujuh",
  "delapan puluh delapan",
  "delapan puluh sembilan", // 80-89
  "sembilan puluh",
  "sembilan puluh satu",
  "sembilan puluh dua",
  "sembilan puluh tiga",
  "sembilan puluh empat",
  "sembilan puluh lima",
  "sembilan puluh enam",
  "sembilan puluh tujuh",
  "sembilan puluh delapan",
  "sembilan puluh sembilan", // 90-99
];

/// Kosakata tambahan yang digunakan dalam pengumuman pembayaran.
const Map<String, String> indonesianExtraWords = {
  "se": "se",
  "ratus": "ratus",
  "ribu": "ribu",
  "juta": "juta",
  "plhjt": "puluh juta",
  "miliar": "miliar",
  "rupiah": "rupiah",
  "sen": "sen",
  "saja": "saja",
  "diterima": "telah diterima",
  "dan": "dan",
};

// Aliases untuk kompatibilitas mundur (jika masih dipanggil di tempat lain)
@Deprecated('Gunakan indonesianNumbers0To99')
const List<String> nepaliNumbers0To99 = indonesianNumbers0To99;

@Deprecated('Gunakan indonesianExtraWords')
const Map<String, String> nepaliExtraWords = indonesianExtraWords;
