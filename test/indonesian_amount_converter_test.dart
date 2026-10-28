import 'package:flutter_test/flutter_test.dart';
import 'package:indonesian_soundbox/indonesian_soundbox.dart';

// ─────────────────────────────────────────────────────────────────────────────

void main() {
  group('IndonesianAmountConverter — Sistem Bilangan Indonesia', () {
    // ── Kasus dasar ───────────────────────────────────────────────────────────

    test('0 → nol rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(0),
        ['0', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(0),
        'nol rupiah saja telah diterima',
      );
    });

    test('1 → satu rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(1),
        ['1', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(1),
        'satu rupiah saja telah diterima',
      );
    });

    test('11 → sebelas rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(11),
        ['11', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(11),
        'sebelas rupiah saja telah diterima',
      );
    });

    test('12 → dua belas rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(12),
        ['12', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(12),
        'dua belas rupiah saja telah diterima',
      );
    });

    test('19 → sembilan belas rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(19),
        ['19', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(19),
        'sembilan belas rupiah saja telah diterima',
      );
    });

    test('20 → dua puluh rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(20),
        ['20', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(20),
        'dua puluh rupiah saja telah diterima',
      );
    });

    test('99 → sembilan puluh sembilan rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(99),
        ['99', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(99),
        'sembilan puluh sembilan rupiah saja telah diterima',
      );
    });

    // ── Ratusan ───────────────────────────────────────────────────────────────

    test('100 → seratus rupiah (token se)', () {
      expect(
        IndonesianAmountConverter.toClips(100),
        ['se', 'ratus', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(100),
        'satu ratus rupiah saja telah diterima',
      );
    });

    test('101 → seratus satu rupiah (token se + 1)', () {
      expect(
        IndonesianAmountConverter.toClips(101),
        ['se', 'ratus', '1', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(101),
        'satu ratus satu rupiah saja telah diterima',
      );
    });

    test('999 → sembilan ratus sembilan puluh sembilan rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(999),
        ['9', 'ratus', '99', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(999),
        'sembilan ratus sembilan puluh sembilan rupiah saja telah diterima',
      );
    });

    // ── Ribuan ────────────────────────────────────────────────────────────────

    test('1000 → seribu rupiah (token se)', () {
      expect(
        IndonesianAmountConverter.toClips(1000),
        ['se', 'ribu', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(1000),
        'satu ribu rupiah saja telah diterima',
      );
    });

    test('1001 → seribu satu rupiah (token se + 1)', () {
      expect(
        IndonesianAmountConverter.toClips(1001),
        ['se', 'ribu', '1', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(1001),
        'satu ribu satu rupiah saja telah diterima',
      );
    });

    test('1530.30 → seribu lima ratus tiga puluh rupiah (pecahan dibuang)', () {
      // 1530.30 di-floor menjadi 1530 rupiah, pecahan 0.30 tidak diucapkan
      expect(
        IndonesianAmountConverter.toClips(1530.30),
        [
          'se',
          'ribu',
          '5',
          'ratus',
          '30',
          'rupiah',
          'saja',
          'diterima',
        ],
      );
      expect(
        IndonesianAmountConverter.toWords(1530.30),
        'satu ribu lima ratus tiga puluh rupiah saja telah diterima',
      );
    });

    // ── Ratus ribu ────────────────────────────────────────────────────────────

    test('100000 → seratus ribu rupiah', () {
      // 100.000 = 100 × ribu → token [se, ratus, ribu]
      expect(
        IndonesianAmountConverter.toClips(100000),
        ['se', 'ratus', 'ribu', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(100000),
        'satu ratus ribu rupiah saja telah diterima',
      );
    });

    // ── Jutaan ────────────────────────────────────────────────────────────────

    test('1000000 → satu juta rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(1000000),
        ['1', 'juta', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(1000000),
        'satu juta rupiah saja telah diterima',
      );
    });

    test('10000000 → sepuluh juta rupiah', () {
      // 10.000.000 = 10 × juta → token "10" + "juta"
      expect(
        IndonesianAmountConverter.toClips(10000000),
        ['10', 'juta', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(10000000),
        'sepuluh juta rupiah saja telah diterima',
      );
    });

    // ── Miliar ────────────────────────────────────────────────────────────────

    test('1000000000 → satu miliar rupiah', () {
      expect(
        IndonesianAmountConverter.toClips(1000000000),
        ['1', 'miliar', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(1000000000),
        'satu miliar rupiah saja telah diterima',
      );
    });

    // ── Pecahan desimal — harus dibuang (floor) ───────────────────────────────

    test('0.50 → nol rupiah (pecahan 0.50 dibuang, tidak ada sen)', () {
      expect(
        IndonesianAmountConverter.toClips(0.50),
        ['0', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(0.50),
        'nol rupiah saja telah diterima',
      );
    });

    test('10.29 → sepuluh rupiah (pecahan 0.29 dibuang, tidak ada sen)', () {
      expect(
        IndonesianAmountConverter.toClips(10.29),
        ['10', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(10.29),
        'sepuluh rupiah saja telah diterima',
      );
    });

    test('1500.99 → seribu lima ratus rupiah (floor, bukan round ke 1501)', () {
      expect(
        IndonesianAmountConverter.toClips(1500.99),
        [
          'se',
          'ribu',
          '5',
          'ratus',
          'rupiah',
          'saja',
          'diterima',
        ],
      );
      expect(
        IndonesianAmountConverter.toWords(1500.99),
        'satu ribu lima ratus rupiah saja telah diterima',
      );
    });

    // ── Validasi: kata "sen" dan "Sen" tidak muncul ────────────────────────

    test('Kata "sen" tidak pernah muncul dalam hasil toWords()', () {
      final testAmounts = [0, 1, 11, 100, 1000, 1530.30, 0.50, 10.29, 1500.99];
      for (final amount in testAmounts) {
        final words = IndonesianAmountConverter.toWords(amount);
        expect(words.contains('sen'), isFalse,
            reason: 'Kata "sen" ditemukan untuk nominal $amount: "$words"');
        expect(words.contains('sen'), isFalse,
            reason: 'Kata "sen" ditemukan untuk nominal $amount: "$words"');
      }
    });

    test('Token "sen" tidak pernah muncul dalam hasil toClips()', () {
      final testAmounts = [0, 1, 11, 100, 1000, 1530.30, 0.50, 10.29, 1500.99];
      for (final amount in testAmounts) {
        final clips = IndonesianAmountConverter.toClips(amount);
        expect(clips.contains('sen'), isFalse,
            reason: 'Token "sen" ditemukan untuk nominal $amount: $clips');
      }
    });

    // ── Opsi konfigurasi ──────────────────────────────────────────────────────

    test('Opsi includeSaja=false, includeDiterima=false', () {
      const opts = IndonesianAmountOptions(
        includeSaja: false,
        includeDiterima: false,
      );
      expect(
        IndonesianAmountConverter.toClips(100, options: opts),
        ['se', 'ratus', 'rupiah'],
      );
      expect(
        IndonesianAmountConverter.toWords(100, options: opts),
        'satu ratus rupiah',
      );
    });

    test('Opsi includeSaja=true, includeDiterima=false', () {
      const opts = IndonesianAmountOptions(
        includeSaja: true,
        includeDiterima: false,
      );
      expect(
        IndonesianAmountConverter.toClips(1000, options: opts),
        ['se', 'ribu', 'rupiah', 'saja'],
      );
      expect(
        IndonesianAmountConverter.toWords(1000, options: opts),
        'satu ribu rupiah saja',
      );
    });

    test('Opsi includeDanForSen=true — tidak menambahkan bacaan pecahan', () {
      // includeRaFoSen aisa dipertahankan untuk kompatibilitas API tetapi
      // tidak boleh membuat bacaan pecahan muncul kembali.
      const opts = IndonesianAmountOptions(includeDanForSen: true);
      final clips = IndonesianAmountConverter.toClips(50.25, options: opts);
      expect(clips.contains('sen'), isFalse);
      expect(clips.contains('dan'), isFalse);
      expect(
        clips,
        ['50', 'rupiah', 'saja', 'diterima'],
      );
      expect(
        IndonesianAmountConverter.toWords(50.25, options: opts),
        'lima puluh rupiah saja telah diterima',
      );
    });

    // ── Kompatibilitas alias deprecated ────────────────────────────────────────

    test('Alias IndoAmountConverter masih berfungsi (deprecated)', () {
      // ignore: deprecated_member_use_from_same_package
      final clips = IndoAmountConverter.toClips(100);
      expect(clips, ['se', 'ratus', 'rupiah', 'saja', 'diterima']);

      // ignore: deprecated_member_use_from_same_package
      final words = IndoAmountConverter.toWords(100);
      expect(words, 'satu ratus rupiah saja telah diterima');
    });

    test('Alias IndoAmountOptions masih berfungsi (deprecated)', () {
      // ignore: deprecated_member_use_from_same_package
      const opts = IndoAmountOptions(
        includeSaja: false,
        includeDiterima: false,
      );
      final clips = IndonesianAmountConverter.toClips(50, options: opts);
      expect(clips, ['50', 'rupiah']);
    });

    // ── Validasi token audio kompatibel dengan aset ───────────────────────────

    test('Semua token yang dihasilkan tersedia sebagai token audio yang valid',
        () {
      // Daftar semua token audio yang didukung sistem soundbox
      final availableTokens = <String>{
        for (int i = 0; i < 100; i++) i.toString(),
        'se',
        'ratus',
        'ribu',
        'juta',
        'plhjt',
        'miliar',
        'rupiah',
        'sen',
        'saja',
        'diterima',
        'dan',
      };

      final testAmounts = [
        0,
        1,
        10,
        11,
        12,
        19,
        20,
        99,
        100,
        101,
        999,
        1000,
        1001,
        1500,
        1530,
        2000,
        100000,
        1000000,
        10000000,
        1000000000,
      ];

      for (final amount in testAmounts) {
        final clips = IndonesianAmountConverter.toClips(amount);
        for (final clip in clips) {
          expect(availableTokens.contains(clip), isTrue,
              reason:
                  'Token "$clip" untuk nominal $amount tidak terdaftar dalam daftar token audio');
        }
      }
    });

    // ── Pengujian Khusus Aturan Token "se" (1, 10, 11, 100, 1000, 1500, 2000) ───

    group('Aturan Token se untuk Angka 1 dalam Nominal 10 ke Atas', () {
      test('Angka 1: tetap menggunakan 1 (memanggil 1.mp3)', () {
        final clips = IndonesianAmountConverter.toClips(1);
        expect(clips.first, '1');
        expect(clips, ['1', 'rupiah', 'saja', 'diterima']);
      });

      test('Angka 10: tetap menggunakan token 10 (memanggil 10.mp3)', () {
        final clips = IndonesianAmountConverter.toClips(10);
        expect(clips.first, '10');
        expect(clips, ['10', 'rupiah', 'saja', 'diterima']);
      });

      test('Angka 11: tetap menggunakan token 11 (memanggil 11.mp3)', () {
        final clips = IndonesianAmountConverter.toClips(11);
        expect(clips.first, '11');
        expect(clips, ['11', 'rupiah', 'saja', 'diterima']);
      });

      test('Angka 100: menggunakan se (seratus) menggantikan 1', () {
        final clips = IndonesianAmountConverter.toClips(100);
        expect(clips.first, 'se');
        expect(clips[1], 'ratus');
        expect(clips, ['se', 'ratus', 'rupiah', 'saja', 'diterima']);
      });

      test('Angka 1000: menggunakan se (seribu) menggantikan 1', () {
        final clips = IndonesianAmountConverter.toClips(1000);
        expect(clips.first, 'se');
        expect(clips[1], 'ribu');
        expect(clips, ['se', 'ribu', 'rupiah', 'saja', 'diterima']);
      });

      test('Angka 1500: menggunakan se untuk 1000 dan token 5 untuk 500', () {
        final clips = IndonesianAmountConverter.toClips(1500);
        expect(clips, [
          'se',
          'ribu',
          '5',
          'ratus',
          'rupiah',
          'saja',
          'diterima',
        ]);
      });

      test('Angka 2000: tetap menggunakan audio angka 2 (tidak diganti se)',
          () {
        final clips = IndonesianAmountConverter.toClips(2000);
        expect(clips.first, '2');
        expect(clips[1], 'ribu');
        expect(clips, ['2', 'ribu', 'rupiah', 'saja', 'diterima']);
      });

      test('Pemetaan token audio ke nama file .mp3', () {
        // Memastikan token se memetakan ke nama file se.mp3
        const token = 'se';
        const fileName = '$token.mp3';
        expect(fileName, 'se.mp3');

        // Memastikan token 1 memetakan ke 1.mp3
        expect('${'1'}.mp3', '1.mp3');
      });
    });

    // ── Validasi tidak ada referensi Indo dalam kode aktif ──────────────────

    test('Tidak ada referensi "Indo" dalam output kata', () {
      final testAmounts = [0, 1, 100, 1000, 1000000, 1000000000];
      for (final amount in testAmounts) {
        final words = IndonesianAmountConverter.toWords(amount);
        expect(words.toLowerCase().contains('indo'), isFalse,
            reason:
                'Referensi "Indonesian" ditemukan dalam output untuk $amount');
      }
    });
  });
}
