import 'package:belajar_isyarat/entitas/profil/e_log_detail.dart';
import 'package:belajar_isyarat/entitas/profil/e_progress_belajar.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';

class SistemSaran {
  // ==========================
  // PARAMETER (PATOKAN NILAI)
  // ==========================
  final List<ELogDetail> logList;
  final List<int> nilaiTes;
  final EProgressBelajar statusBelajar;
  final int totalMateri;
  final int totalMateriSelesai;

  // BELAJAR
  final int belajarMaxPoin;
  final int belajarMinPoin;
  final int belajarPoinSemuaSelesai;
  final int belajarPoinSatuSisa;
  final int belajarPotonganPerAksi;
  final int belajarPotonganFullJika10;

  // TES
  final int tesMaxPoin;
  final int tesMinPoin;
  final int tesPoinSemua100;
  final int tesPoinSemua100DenganAktivitas;

  // KUIS
  final int kuisMaxPoin;
  final int kuisMinPoin;
  final int kuisMinPoinJikaSalah40;
  final int kuisMinPoinJikaBenar15;
  final int kuisPoin0JikaSalah50;
  final int kuisPoin0JikaBenar20;

  SistemSaran({
    required this.logList,
    required this.nilaiTes,
    required this.statusBelajar,
    required this.totalMateri,
    required this.totalMateriSelesai,

    // PARAMETER BELAJAR
    this.belajarMaxPoin = 200,
    this.belajarMinPoin = 60,
    this.belajarPoinSemuaSelesai = 20,
    this.belajarPoinSatuSisa = 60,
    this.belajarPotonganPerAksi = 2,
    this.belajarPotonganFullJika10 = 0,

    // PARAMETER TES
    this.tesMaxPoin = 170,
    this.tesMinPoin = 20,
    this.tesPoinSemua100 = 5,
    this.tesPoinSemua100DenganAktivitas = 0,

    // PARAMETER KUIS
    this.kuisMaxPoin = 140,
    this.kuisMinPoin = 3,
    this.kuisMinPoinJikaSalah40 = 3,
    this.kuisMinPoinJikaBenar15 = 3,
    this.kuisPoin0JikaSalah50 = 0,
    this.kuisPoin0JikaBenar20 = 0,
  });

  // ====================================
  // UTILITAS CEK LOG
  // ====================================

  bool adaBelajar2HariTerakhir() {
    final batas = DateTime.now().subtract(Duration(days: 2));
    return logList.any((log) =>
        log.tipe == "belajar" && log.waktu.isAfter(batas));
  }

  int totalBelajar2HariTerakhir() {
    final batas = DateTime.now().subtract(Duration(days: 2));
    return logList
        .where((log) =>
            log.tipe == "belajar" && log.waktu.isAfter(batas))
        .length;
  }

  bool adaTes2HariTerakhir() {
    final batas = DateTime.now().subtract(Duration(days: 2));
    return logList.any((log) =>
        log.tipe == "tes" &&
        log.aksi == "tes_selesai" &&
        log.waktu.isAfter(batas));
  }

  List<ELogDetail> ambilKuis5Hari() {
    final batas = DateTime.now().subtract(Duration(days: 5));
    return logList.where((log) =>
        log.tipe == "kuis" &&
        log.aksi == "kuis_jawab" &&
        log.waktu.isAfter(batas)).toList();
  }

  // ====================================
  // HITUNG POIN — BELAJAR
  // ====================================
  int hitungPoinBelajar() {
    if (totalMateriSelesai >= totalMateri) return belajarPoinSemuaSelesai;
    if (totalMateriSelesai == totalMateri - 1) return belajarMinPoin;

    double progres = (totalMateri - totalMateriSelesai) / totalMateri;
    int poin = (progres * belajarMaxPoin).round();

    int aksi2hari = totalBelajar2HariTerakhir();
    if (aksi2hari >= 10) poin = belajarPotonganFullJika10;
    else if (aksi2hari >= 1) poin -= belajarPotonganPerAksi;

    if (poin < belajarPoinSemuaSelesai) poin = belajarPoinSemuaSelesai;
    if (poin > belajarMaxPoin) poin = belajarMaxPoin;

    return poin;
  }

  // ====================================
  // HITUNG POIN — TES
  // ====================================
  int hitungPoinTes() {
    if (nilaiTes.isEmpty) return tesMaxPoin;

    final semua100 = nilaiTes.every((n) => n == 100);
    if (semua100) {
      return adaTes2HariTerakhir()
          ? tesPoinSemua100DenganAktivitas
          : tesPoinSemua100;
    }

    double totalFraction = 0;
    for (var nilai in nilaiTes) {
      if (nilai < 50) totalFraction += 1.0;
      else if (nilai < 75) totalFraction += 0.7;
      else if (nilai < 85) totalFraction += 0.4;
      else if (nilai < 95) totalFraction += 0.1;
      else totalFraction += 0.0;
    }

    int poin = (totalFraction * tesMaxPoin).round();

    if (poin < tesMinPoin) poin = tesMinPoin;
    if (poin > tesMaxPoin) poin = tesMaxPoin;

    return poin;
  }

  // ====================================
  // HITUNG POIN — KUIS
  // ====================================
  int hitungPoinKuis() {
    final kuis = ambilKuis5Hari();
    if (kuis.isEmpty) return kuisMaxPoin;

    int benar = 0;
    int salah = 0;

    for (var log in kuis) {
      if (log.jawabanBenar == true) benar++;
      else salah++;
    }

    if (salah >= 50) return kuisPoin0JikaSalah50;
    if (salah >= 40) return kuisMinPoinJikaSalah40;
    if (benar >= 20) return kuisPoin0JikaBenar20;
    if (benar >= 15) return kuisMinPoinJikaBenar15;

    final total = benar + salah;
    if (total == 0) return kuisMaxPoin;

    double ratioSalah = salah / total;
    int poin = ((1 - ratioSalah) * kuisMaxPoin).round();

    if (poin < kuisMinPoin) poin = kuisMinPoin;
    return poin;
  }

  // ====================================
  // REKOMENDASI
  // ====================================
  Map<String, int>? modulRekomendasiBelajar() {
    String? modulDipilih;
    int jumlahFalseTerbanyak = -1;

    statusBelajar.modul.forEach((modul, materiObj) {
      int countFalse = materiObj.status.values.where((v) => !v).length;

      if (countFalse > jumlahFalseTerbanyak) {
        jumlahFalseTerbanyak = countFalse;
        modulDipilih = modul;
      }
    });

    if (modulDipilih == null) return null;

    // ambil materi pertama yang false
    int materiPertama = statusBelajar.modul[modulDipilih]!
        .status
        .entries
        .firstWhere((e) => !e.value)
        .key;

    return {
      "modul": int.parse(modulDipilih!.split("_").last),
      "materi": materiPertama,
    };
  }

  int rekomendasiTes() {
    if (nilaiTes.isEmpty) return 1;

    int index = 0;
    int minValue = nilaiTes[0];

    for (int i = 1; i < nilaiTes.length; i++) {
      if (nilaiTes[i] < minValue) {
        minValue = nilaiTes[i];
        index = i;
      }
    }
    return index + 1;
  }

  // ====================================
  // PESAN PENYEMANGAT (KEKURANGAN)
  // ====================================
  String penyemangatBelajar(int poin) {
    if (poin >= 150) return "Keren! Kemajuan belajarmu sangat baik.";
    if (poin >= 100) return "Bagus! Kamu sudah berada di jalur yang benar.";
    if (poin >= 60) return "Cukup baik. Tingkatkan sedikit lagi!";
    return "Tetap semangat! Kamu pasti bisa meningkatkan progres belajarmu.";
  }

  String penyemangatTes(int poin) {
    if (poin >= 120) return "Hasil tesmu luar biasa!";
    if (poin >= 80) return "Bagus! Nilai tesmu cukup stabil.";
    if (poin >= 40) return "Cukup baik. Tetap tingkatkan terus.";
    return "Tetap semangat! Perlu sedikit lebih fokus pada tes berikutnya.";
  }

  String penyemangatKuis(int poin, bool kekuranganUtama) {
    if (kekuranganUtama && poin == 3) {
      return "Jangan menyerah! Kuis memang menantang, tapi kamu pasti bisa meningkat pesat!";
    }

    if (poin >= 100) return "Luar biasa! Kamu menguasai banyak kuis.";
    if (poin >= 60) return "Bagus! Pertahankan dan terus tingkatkan.";
    if (poin >= 20) return "Tidak buruk! Terus latih kemampuanmu.";
    return "Tetap semangat! Kuis bisa jadi langkah penting untuk memperkuat pemahamanmu.";
  }

  // ====================================
  // KELEBIHAN (STRENGTH DETECTION)
  // ====================================
  String? kategoriKelebihan(int pb, int pt, int pk) {
    List<String> kandidat = [];

    if (pb >= belajarMaxPoin * 0.5) kandidat.add("belajar");
    if (pt >= tesMaxPoin * 0.5) kandidat.add("tes");
    if (pk >= kuisMaxPoin * 0.5) kandidat.add("kuis");

    if (kandidat.isEmpty) return null;

    Map<String, int> nilai = {"belajar": pb, "tes": pt, "kuis": pk};

    kandidat.sort((a, b) => nilai[a]!.compareTo(nilai[b]!));
    String terpilih = kandidat.first;

    int minVal = nilai[terpilih]!;
    List<String> tie = kandidat.where((k) => nilai[k] == minVal).toList();

    if (tie.length > 1) {
      if (tie.contains("belajar")) return "belajar";
      if (tie.contains("tes")) return "tes";
      return "kuis";
    }

    return terpilih;
  }

  // pesan kelebihan
  String pesanKelebihanBelajar(int poin) {
    if (poin >= 150) return "Kemampuan belajarmu sangat luar biasa!";
    if (poin >= 120) return "Kamu belajar dengan konsisten. Lanjutkan!";
    return "Belajarmu stabil. Kamu berada di jalur yang tepat!";
  }

  String pesanKelebihanTes(int poin) {
    if (poin >= 140) return "Nilai tesmu sangat kuat dan stabil!";
    if (poin >= 110) return "Kamu cukup kuat dalam tes. Pertahankan!";
    return "Tes-tes yang kamu kerjakan menunjukkan performa yang baik!";
  }

  String pesanKelebihanKuis(int poin) {
    if (poin >= 110) return "Kemampuanmu menjawab kuis luar biasa!";
    if (poin >= 90) return "Kamu ahli dalam latihan kuis!";
    return "Kamu cukup andal menjawab kuis. Pertahankan!";
  }

  Map<String, dynamic>? hasilKelebihan(int pb, int pt, int pk) {
    if (pb == 0 && pt == 0 && pk == 0) {
      return {
        "kategori": "selesai",
        "pesan": "Kamu sudah menyelesaikan semua tantangan. Sekarang tinggal mempertahankan kemampuanmu."
      };
    }

    String? kategori = kategoriKelebihan(pb, pt, pk);
    if (kategori == null) return null;

    late String pesan;
    if (kategori == "belajar") pesan = pesanKelebihanBelajar(pb);
    else if (kategori == "tes") pesan = pesanKelebihanTes(pt);
    else pesan = pesanKelebihanKuis(pk);

    return {
      "kategori": kategori,
      "pesan": pesan,
    };
  }

  // ====================================
  // KEKURANGAN
  // ====================================

  Map<String, dynamic> hasilKekurangan(int pb, int pt, int pk) {
    int maxPoin = [pb, pt, pk].reduce((a, b) => a > b ? a : b);

    String kategori = (maxPoin == pb)
        ? "belajar"
        : (maxPoin == pt ? "tes" : "kuis");

    late String penyemangat;
    late String rekomendasi;

    if (kategori == "belajar") {
      penyemangat = penyemangatBelajar(pb);
      final r = modulRekomendasiBelajar();
      if (r == null) {
        rekomendasi =
            "Semua modul sudah selesai. Pertahankan pemahamanmu dengan mengulang materi penting.";
      } else {
        rekomendasi =
            "Cobalah lanjutkan Modul ${r["modul"]}, Materi ${r["materi"]}.";
      }
    } else if (kategori == "tes") {
      penyemangat = penyemangatTes(pt);
      rekomendasi = "Nilai terendah berada di Modul ${rekomendasiTes()}. Pelajari kembali modul tersebut.";
    } else {
      penyemangat = penyemangatKuis(pk, true);
      rekomendasi = "Terus latih kuis secara rutin untuk memperkuat pemahaman.";
    }

    return {
      "tipe": "kekurangan",
      "kategori": kategori,
      "pesan": penyemangat,
      "rekomendasi": rekomendasi,
      "poin": {"belajar": pb, "tes": pt, "kuis": pk}
    };
  }

  // ====================================
  // HASIL AKHIR
  // ====================================
  Map<String, dynamic> hasilAkhir() {
    int pb = hitungPoinBelajar();
    int pt = hitungPoinTes();
    int pk = hitungPoinKuis();

    final kelebihan = hasilKelebihan(pb, pt, pk);
    if (kelebihan != null) {
      return {
        "tipe": "kelebihan",
        "kategori": kelebihan["kategori"],
        "pesan": kelebihan["pesan"],
        "poin": {"belajar": pb, "tes": pt, "kuis": pk}
      };
    }

    return hasilKekurangan(pb, pt, pk);
  }
}