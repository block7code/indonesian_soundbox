import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'indonesian_amount_converter.dart';

/// Pemutar audio Soundbox untuk mengumumkan nominal pembayaran dalam Bahasa Indonesia.
class IndonesianSoundbox {
  final AudioPlayer _player;
  bool _isPlaying = false;
  Completer<void>? _currentPlaybackCompleter;

  /// Pengali kecepatan pemutaran audio (misalnya 1.0 untuk normal, 1.1 untuk pengumuman lebih cepat).
  double speed;

  /// Jeda tambahan dalam milidetik antara klip audio berturut-turut (misalnya 0 hingga 200 ms).
  int gapMs;

  /// Cache memori untuk byte klip audio (total ukuran untuk seluruh 110 klip adalah ~700 KB).
  static final Map<String, Uint8List> _audioCache = {};

  /// Membuat instans [IndonesianSoundbox].
  IndonesianSoundbox({
    AudioPlayer? player,
    this.speed = 1.0,
    this.gapMs = 0,
  }) : _player = player ?? AudioPlayer();

  /// Menunjukkan apakah audio sedang diputar.
  bool get isPlaying => _isPlaying;

  /// Instans [AudioPlayer] yang digunakan di balik layar.
  AudioPlayer get player => _player;

  /// Mengucapkan nominal pembayaran [amount] yang diberikan dalam Bahasa Indonesia.
  ///
  /// Contoh:
  /// ```dart
  /// final soundbox = IndonesianSoundbox(gapMs: 50);
  /// await soundbox.speakAmount(1530.30);
  /// ```
  Future<void> speakAmount(
    num amount, {
    IndonesianAmountOptions options = const IndonesianAmountOptions(),
    void Function(String clip, int index)? onClipStarted,
    double? speed,
    int? gapMs,
  }) async {
    final clips = IndonesianAmountConverter.toClips(amount, options: options);
    await playClips(
      clips,
      onClipStarted: onClipStarted,
      speed: speed,
      gapMs: gapMs,
    );
  }

  /// Memuat byte klip audio dari asset bundle, memeriksa kemungkinan prefiks paket.
  Future<Uint8List> _loadClipBytes(String clipKey) async {
    if (_audioCache.containsKey(clipKey)) {
      return _audioCache[clipKey]!;
    }

    final candidates = [
      "packages/soundbox_indonesian/assets/audio/$clipKey.mp3",
      "packages/indonesian_soundbox/assets/audio/$clipKey.mp3",
      "packages/indonesian_tts/assets/audio/$clipKey.mp3",
      "assets/audio/$clipKey.mp3",
      "audio/$clipKey.mp3",
    ];

    for (final candidate in candidates) {
      try {
        final byteData = await rootBundle.load(candidate);
        final bytes = byteData.buffer.asUint8List();
        _audioCache[clipKey] = bytes;
        return bytes;
      } catch (_) {
        // Coba kandidat berikutnya
      }
    }

    throw FlutterError(
      "Tidak dapat menemukan aset audio '$clipKey.mp3' di dalam bundle. Telah memeriksa: $candidates",
    );
  }

  /// Memutar urutan kunci klip audio yang diberikan secara berurutan.
  Future<void> playClips(
    List<String> clipKeys, {
    void Function(String clip, int index)? onClipStarted,
    double? speed,
    int? gapMs,
  }) async {
    await stop();

    if (clipKeys.isEmpty) return;

    final effectiveSpeed = speed ?? this.speed;
    final effectiveGapMs = gapMs ?? this.gapMs;

    _isPlaying = true;
    final completer = Completer<void>();
    _currentPlaybackCompleter = completer;

    try {
      if (effectiveSpeed != 1.0) {
        try {
          await _player.setPlaybackRate(effectiveSpeed);
        } catch (_) {}
      }

      for (int i = 0; i < clipKeys.length; i++) {
        if (!_isPlaying || completer.isCompleted) break;
        final key = clipKeys[i];

        onClipStarted?.call(key, i);
        debugPrint("[Soundbox] Memutar klip [$i/${clipKeys.length}]: $key.mp3");

        final bytes = await _loadClipBytes(key);

        final completionFuture = Future.any<void>([
          _player.onPlayerComplete.first,
          Future<void>.delayed(const Duration(seconds: 2)),
        ]);

        await _player.play(BytesSource(bytes));
        if (effectiveSpeed != 1.0) {
          try {
            await _player.setPlaybackRate(effectiveSpeed);
          } catch (_) {}
        }
        await completionFuture;

        // Terapkan jeda kecil antara klip berturut-turut jika diminta
        if (effectiveGapMs > 0 && i < clipKeys.length - 1 && _isPlaying) {
          await Future<void>.delayed(Duration(milliseconds: effectiveGapMs));
        }
      }
    } catch (e, st) {
      debugPrint("[Soundbox] Kesalahan pemutaran: $e\n$st");
      rethrow;
    } finally {
      _isPlaying = false;
      if (!completer.isCompleted) {
        completer.complete();
      }
      if (_currentPlaybackCompleter == completer) {
        _currentPlaybackCompleter = null;
      }
    }
  }

  /// Memuat awal (preload) seluruh klip audio ke memori untuk pemutaran instan.
  ///
  /// Token `sen` dan `plhjt` masih dimuat karena file audio tersedia,
  /// meskipun tidak lagi digunakan oleh converter Indonesia.
  static Future<void> preloadAll() async {
    final soundbox = IndonesianSoundbox();
    final allKeys = [
      for (int i = 0; i < 100; i++) i.toString(),
      "se",
      "ratus",
      "ribu",
      "juta",
      "plhjt",
      "miliar",
      "rupiah",
      "sen",
      "saja",
      "diterima",
      "dan",
    ];
    for (final key in allKeys) {
      try {
        await soundbox._loadClipBytes(key);
      } catch (_) {}
    }
    await soundbox.dispose();
  }

  /// Menghentikan pemutaran audio yang sedang berjalan saat ini.
  Future<void> stop() async {
    _isPlaying = false;
    final c = _currentPlaybackCompleter;
    _currentPlaybackCompleter = null;
    if (c != null && !c.isCompleted) {
      c.complete();
    }
    try {
      await _player.stop();
    } catch (_) {}
  }

  /// Melepaskan sumber daya audio player.
  Future<void> dispose() async {
    await stop();
    await _player.dispose();
  }
}

/// Alias kompatibilitas mundur untuk [IndonesianSoundbox].
@Deprecated('Gunakan IndonesianSoundbox')
typedef IndoSoundbox = IndonesianSoundbox;

/// Alias kompatibilitas mundur untuk [IndonesianSoundbox].
@Deprecated('Gunakan IndonesianSoundbox')
typedef IndoTTS = IndonesianSoundbox;

/// Alias Bahasa Indonesia tambahan untuk [IndonesianSoundbox].
typedef SoundboxIndonesia = IndonesianSoundbox;
