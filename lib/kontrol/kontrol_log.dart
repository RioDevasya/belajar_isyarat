import 'package:belajar_isyarat/entitas/profil/e_log.dart';
import 'package:belajar_isyarat/entitas/profil/e_log_detail.dart';
import 'package:belajar_isyarat/kontrol/kontrol_database.dart';

class KontrolLog {
  static final KontrolLog _instansi = KontrolLog._isi();
  factory KontrolLog() => _instansi;
  KontrolLog._isi();

  final String namaFile = "log_aktivitas";

  // =====================================================
  // =============== GETTER: AMBIL SEMUA LOG =============
  // =====================================================
  Future<ELog> ambilLog() async {
    final raw = await KontrolDatabase().ambilJson(namaFile);
    return ELog.fromJson(raw);
  }

  Future<List<ELogDetail>> ambilListLog() async {
    return (await ambilLog()).list;
  }

  // =====================================================
  // ===================== SETTER ========================
  // =====================================================

  /// Internal function untuk menambah log
  Future<void> _tambahLog(ELogDetail data) async {
    final logs = await ambilLog();
    logs.list.add(data);
    await KontrolDatabase().simpanJson(namaFile, logs.toJson());
  }

  // ------------------ BELAJAR -------------------------
  Future<void> catatLogBelajar({
    required int modul,
    required int materi,
  }) async {
    await _tambahLog(
      ELogDetail(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        waktu: DateTime.now(),
        tipe: "belajar",
        modul: modul,
        materi: materi,
        aksi: "materi_selesai",
      ),
    );
  }

  // ------------------ KUIS ----------------------------
  Future<void> catatLogKuis({
    required int idKuis,
    required bool jawabanBenar,
  }) async {
    await _tambahLog(
      ELogDetail(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        waktu: DateTime.now(),
        tipe: "kuis",
        idKuis: idKuis,
        jawabanBenar: jawabanBenar,
        skor: jawabanBenar ? 100 : 25,
        aksi: "kuis_jawab",
      ),
    );
  }

  // ------------------ TES -----------------------------
  Future<void> catatLogTes({
    required int modul,
    required int skor,
  }) async {
    await _tambahLog(
      ELogDetail(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        waktu: DateTime.now(),
        tipe: "tes",
        modul: modul,
        skor: skor,
        aksi: "tes_selesai",
      ),
    );
  }

  // =====================================================
  // =============== STATISTIK / ANALISA =================
  // =====================================================
  Future<int> totalSkor() async {
    final list = await ambilListLog();
    int total = 0;
    for (final e in list) {
      total += (e.skor ?? 0);
    }
    return total;
  }


  Future<int> totalKuis() async {
    final list = await ambilListLog();
    return list.where((e) => e.tipe == "kuis").length;
  }

  Future<int> totalTes() async {
    final list = await ambilListLog();
    return list.where((e) => e.tipe == "tes").length;
  }

  Future<int> totalMateriSelesai() async {
    final list = await ambilListLog();
    return list.where((e) => e.tipe == "belajar").length;
  }

  /// Untuk chart skor kuis
  Future<List<int>> skorKuisSeries() async {
    final list = await ambilListLog();
    return list
        .where((e) => e.tipe == "kuis")
        .map((e) => e.skor ?? 0)
        .toList();
  }

  /// Untuk chart skor tes
  Future<List<int>> skorTesSeries() async {
    final list = await ambilListLog();
    return list
        .where((e) => e.tipe == "tes")
        .map((e) => e.skor ?? 0)
        .toList();
  }
}