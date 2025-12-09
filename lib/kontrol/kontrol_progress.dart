import 'package:belajar_isyarat/entitas/profil/e_progress_belajar.dart';
import 'package:belajar_isyarat/entitas/profil/e_progress_kuis.dart';
import 'package:belajar_isyarat/entitas/profil/e_profil.dart';
import 'package:belajar_isyarat/kontrol/kontrol_belajar.dart';
import 'package:belajar_isyarat/kontrol/kontrol_database.dart'; // jangan masukkan notifyListener. progress hanya dihandle oleh kontrol lain
import 'package:belajar_isyarat/kontrol/kontrol_kuis.dart';
import 'package:belajar_isyarat/kontrol/kontrol_tes.dart';

import 'package:flutter/foundation.dart'; // TODO: persentase. total tes, total belajar.

class KontrolProgress {
  late EProgressBelajar _eProgressBelajar; //.modul<String, status>.status<int, bool>
  late EProgressKuis _eProgressKuis; //.status<int, bool>
  late EProfil _eProfil; //.nama:String,sekolah:String,jabatan:String,progressBelajar[int],nilaiTes[int],progressKuis:int

  // inisialisasi (anti error)
  Future<bool> inis(KontrolDatabase kontrolDatabase) async {
    final dataProfil = await kontrolDatabase.ambilJson('profil');
    _eProfil = EProfil.fromJson(dataProfil);

    if (_eProfil.bahasaInggris) {
      final dataProgressBelajar = await kontrolDatabase.ambilJson('belajar_progress_inggris');
      final dataProgressKuis = await kontrolDatabase.ambilJson('kuis_progress_inggris');
      _eProgressBelajar = EProgressBelajar.fromJson(dataProgressBelajar);
      _eProgressKuis = EProgressKuis.fromJson(dataProgressKuis);
    } else {
      final dataProgressBelajar = await kontrolDatabase.ambilJson('belajar_progress_indo');
      final dataProgressKuis = await kontrolDatabase.ambilJson('kuis_progress_indo');
      _eProgressBelajar = EProgressBelajar.fromJson(dataProgressBelajar);
      _eProgressKuis = EProgressKuis.fromJson(dataProgressKuis);
    }
    return true;
  }

  Future<bool> _inisDataProgress(KontrolDatabase kontrolDatabase) async {
    if (_eProfil.bahasaInggris) {
      final dataProgressBelajar = await kontrolDatabase.ambilJson('belajar_progress_inggris');
      final dataProgressKuis = await kontrolDatabase.ambilJson('kuis_progress_inggris');
      _eProgressBelajar = EProgressBelajar.fromJson(dataProgressBelajar);
      _eProgressKuis = EProgressKuis.fromJson(dataProgressKuis);
      print("objek 2");
    } else {
      final dataProgressBelajar = await kontrolDatabase.ambilJson('belajar_progress_indo');
      final dataProgressKuis = await kontrolDatabase.ambilJson('kuis_progress_indo');
      _eProgressBelajar = EProgressBelajar.fromJson(dataProgressBelajar);
      _eProgressKuis = EProgressKuis.fromJson(dataProgressKuis);
      print("objek 1");
    }

    return true;
  }

  Future<bool> _inisBahasaUlang(
    KontrolBelajar kontrolBelajar,
    KontrolKuis kontrolKuis,
    KontrolTes kontrolTes,
    KontrolDatabase kDatabase, 
    KontrolProgress kProgress
  ) async {
    bool ok3 = await kontrolBelajar.inis(kDatabase, kProgress);

    bool ok4 = await kontrolTes.inis(kDatabase, kProgress);

    bool ok5 = await kontrolKuis.inis(kDatabase, kProgress);

    return ok3 && ok4 && ok5;
  }

  // getter
  EProgressBelajar get eProgressBelajar => _eProgressBelajar;
  String? get nama => _eProfil.nama;
  String? get sekolah => _eProfil.sekolah;
  String? get jabatan => _eProfil.jabatan;
  bool get bahasaInggris => _eProfil.bahasaInggris;
  List<int> get progressBelajar => _eProfil.bahasaInggris ? _eProfil.progressBelajarInggris : _eProfil.progressBelajarIndo;
  List<int> get nilaiTes => _eProfil.bahasaInggris ? _eProfil.nilaiTesInggris : _eProfil.nilaiTesIndo;
  int get progressKuis => _eProfil.bahasaInggris ? _eProfil.progressKuisInggris : _eProfil.progressKuisIndo;

  int ambilSatuNilaiTes(int modul) => _eProfil.bahasaInggris ? _eProfil.nilaiTesInggris[modul - 1] : _eProfil.nilaiTesIndo[modul - 1];

  List<bool> ambilStatusBelajar(int modul) {
    if (!_eProgressBelajar.modul.containsKey(indeksModul(modul))) return []; // contain anti error. bisa dihilangkan sebelum todo nanti1 (agar kesalahan json diketahui)

    return _eProgressBelajar.modul[indeksModul(modul)]!.status.values.toList(); // ! artinya sudah pasti ada nilai, jika tidak maka error
  }

  int ambilTotalSemuaMateri() {
    int materiTotal = 0;

    _eProgressBelajar.modul.forEach((m, value) {
      materiTotal += value.status.entries.length;
    });

    return materiTotal;
  }

  bool ambilStatusMateri(int modul, int materi) {
    return _eProgressBelajar.modul[indeksModul(modul)]!.status[materi] ?? false;
  }

  int ambilTotalStatusSemuaMateri() {
    int materiSelesai = 0;
    _eProgressBelajar.modul.forEach((m, value) =>
      value.status.forEach((s, value) {
        if (value) {
          materiSelesai++;
        }
      })
    );
    return materiSelesai;
  }

  double ambilProgressStatusSemuaMateri() => ambilTotalStatusSemuaMateri() / ambilTotalSemuaMateri();

  List<bool> ambilStatusSemuaKuis() {
    return _eProgressKuis.status.values.toList();
  }

  int ambilTotalSemuaKuis() {
    return _eProgressKuis.status.length;
  }

  bool ambilStatusKuis(int kuis) {
   return _eProgressKuis.status[kuis] ?? false; //Jika bagian kiri null → gunakan bagian kanan.
  }

  String indeksModul(int modul) => "modul_$modul";

  // alat
  void naikkanProgressBelajar(int modul, int materi) {
    if (!ambilStatusMateri(modul, materi)) {
      _eProgressBelajar.modul[indeksModul(modul)]!.status[materi] = true;
      _eProfil.bahasaInggris ? _eProfil.progressBelajarInggris[modul - 1]++ : _eProfil.progressBelajarIndo[modul - 1]++;
    }
  }

  void naikkanProgressKuis(int kuis, bool benar) {
    if (benar) {
      _eProgressKuis.status[kuis] = true;
      _eProfil.bahasaInggris ? _eProfil.progressKuisInggris += 100 : _eProfil.progressKuisIndo += 100;
    } else {
      _eProfil.bahasaInggris ? _eProfil.progressKuisInggris += 25 : _eProfil.progressKuisIndo += 25;
    }
  }

  void naikkanNilaiTes(int nomorTes, int nilai) {
    _eProfil.bahasaInggris ? _eProfil.nilaiTesInggris[nomorTes - 1] = nilai : _eProfil.nilaiTesIndo[nomorTes - 1] = nilai;
  }

  void aturNama(String? nama) {
    _eProfil.nama = nama;
  }

  void aturSekolah(String? sekolah) {
    _eProfil.sekolah = sekolah;
  }

  void aturJabatan(String? jabatan) {
    _eProfil.jabatan = jabatan;
  }

  Future<bool> aturBahasa(
    bool bahasaInggris,
    KontrolBelajar kontrolBelajar,
    KontrolKuis kontrolKuis,
    KontrolTes kontrolTes,
    KontrolDatabase kDatabase, 
    KontrolProgress kProgress
  ) async {
    _eProfil.bahasaInggris = bahasaInggris;

    await _inisDataProgress(kDatabase);
    await _inisBahasaUlang(
      kontrolBelajar,
      kontrolKuis,
      kontrolTes,
      kDatabase, 
      kProgress
    );
    return true;
  }

  //resetProgress...

  // tutup APK
  void simpanPerubahan(KontrolDatabase kontrolDatabase) {
    kontrolDatabase.simpanJson("belajar_progress", _eProgressBelajar.toJson());
    kontrolDatabase.simpanJson("kuis_progress", _eProgressKuis.toJson());
    kontrolDatabase.simpanJson("profil", _eProfil.toJson());
  }
  void simpanProfil(KontrolDatabase kontrolDatabase) {
    kontrolDatabase.simpanJson("profil", _eProfil.toJson());
  }
}