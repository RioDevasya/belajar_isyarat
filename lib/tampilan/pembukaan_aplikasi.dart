import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'package:belajar_isyarat/kontrol/inisialisasi_app.dart';
import 'package:belajar_isyarat/tampilan/menu_root.dart';

class PembukaanAplikasi extends StatefulWidget {
  const PembukaanAplikasi({super.key});

  @override
  State<PembukaanAplikasi> createState() => _PembukaanAplikasiState();
}

class _PembukaanAplikasiState extends State<PembukaanAplikasi> {
  VideoPlayerController? _controller;

  bool _videoDone = false;
  bool _initDone = false;
  bool _navigated = false; // mencegah navigasi ganda

  @override
  void initState() {
    super.initState();
    _initVideo();
    _initApp();
  }

  // -------------------- VIDEO --------------------
  Future<void> _initVideo() async {
    try {
      bool bahasaInggris = jsonDecode(await rootBundle.loadString('lib/database/data/profil.json'))["bahasa_inggris"];
      _controller = VideoPlayerController.asset(
        bahasaInggris ? "lib/database/video/opening_app_english.mp4" : "lib/database/video/opening_app_indo.mp4",
      )
        ..setLooping(false);

      if (_controller == null) {
        debugPrint("VIDEO tidak ditemukan");
        _videoDone = true;
        _tryNavigate();
        return;
      }

      // Wajib gunakan timeout agar tidak freeze di web
      await _controller!.initialize().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          debugPrint("TIMEOUT: Video gagal initialize");
          _videoDone = true;
          _tryNavigate();
          return;
        },
      ).catchError((err) {
        debugPrint("ERROR: $err");
        _videoDone = true;
        _tryNavigate();
      });

      if (!mounted) return;

      setState(() {});

      // Jika play gagal (bisa terjadi di Web)
      _controller!.play().catchError((_) {
        _videoDone = true;
        _tryNavigate();
      });

      _controller!.addListener(_videoListener);
    } catch (e) {
      // Semua error masuk sini
      debugPrint("VIDEO ERROR: $e");
      _videoDone = true;
      _tryNavigate();
    }
  }

  void _videoListener() {
    if (_controller == null) return;

    final duration = _controller!.value.duration;
    final pos = _controller!.value.position;

    if (duration == Duration.zero) return;

    if (pos >= duration - const Duration(milliseconds: 100)) {
      if (!_videoDone) {
        debugPrint("video selesai");
        _videoDone = true;
        _tryNavigate();
      }
    }
  }

  // -------------------- INISIALISASI APP --------------------
  Future<void> _initApp() async {
    final init = context.read<InisialisasiApp>();

    await init.inis(); // inisialisasi asli milikmu

    if (!mounted) return;
    _initDone = true;
    _tryNavigate();
  }

  // -------------------- NAVIGASI --------------------
  void _tryNavigate() {
    if (!mounted) return;
    if (_navigated) return;

    if (_videoDone && _initDone) {
      _navigated = true;
      _goToMenu();
    }
  }

  void _goToMenu() {
    final init = context.read<InisialisasiApp>();

    Future.microtask(() {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              Provider.value(value: init.kontrolDatabase),
              Provider.value(value: init.kontrolProgress),
              Provider.value(value: init.kontrolLog),
              Provider.value(value: init.alatApp),
              ChangeNotifierProvider.value(value: init.kontrolBelajar),
              ChangeNotifierProvider.value(value: init.kontrolMenu),
              ChangeNotifierProvider.value(value: init.kontrolTes),
              ChangeNotifierProvider.value(value: init.kontrolKuis),
            ],
            child: MenuRoot(),
            ),
          ),
        );
    });
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  // -------------------- UI --------------------
  @override
  Widget build(BuildContext context) {

    // Jika controller belum dibuat → tampilkan loading
    if (_controller == null) {
      return const Scaffold(body: ColoredBox(color: Colors.black));
    }

    // Kalau controller ada tapi belum initialized → tunggu
    if (!_controller!.value.isInitialized) {
      return const Scaffold(body: ColoredBox(color: Colors.black));
    }

    // Jika video selesai tapi app belum selesai init
    if (_videoDone && !_initDone) {
      return const LoadingPembukaan();
    }

    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}

// -------------------- LOADING PEMBUKAAN --------------------
class LoadingPembukaan extends StatelessWidget {
  const LoadingPembukaan({super.key});

  @override
  Widget build(BuildContext context) {
    final init = context.watch<InisialisasiApp>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Belajar Isyarat",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(init.status, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("${init.langkah}/${init.total}",
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}