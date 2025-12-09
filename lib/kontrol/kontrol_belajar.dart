import 'package:belajar_isyarat/entitas/belajar/e_belajar.dart';
import 'package:belajar_isyarat/entitas/belajar/e_materi_belajar.dart';
import 'package:belajar_isyarat/kontrol/kontrol_database.dart';
import 'package:belajar_isyarat/kontrol/kontrol_log.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';

import 'package:flutter/foundation.dart';

// kontrol memiliki state UI berbeda beda, jadi nilai var notifier harus bisa 0 (artinya tak aktif)
class KontrolBelajar extends ChangeNotifier {
  int _modul = 0; // 1 sampai n. 0 artinya tidak ada modul aktif
  int _materi = 0; // 1 sampai n
  late EBelajar _eBelajar; //.modul<String, materi>.materi[EMateriBelajar].suara:String,gambar[String],judul:String,penjelasan:String

  Future<bool> inis(KontrolDatabase kontrolDatabase, KontrolProgress kontrolProgress) async {
    final data = kontrolProgress.bahasaInggris 
      ? await kontrolDatabase.ambilJson('belajar_materi_inggris') 
      : await kontrolDatabase.ambilJson('belajar_materi_indo');
    
    _eBelajar = EBelajar.fromJson(data);

    notifyListeners();
    return true;
  }

  // getter
  int get modulSekarang => _modul;
  int get materiSekarang => _materi;
  int get totalMateriSekarang {
    if (_modul == 0) return 0;
    return _eBelajar.modul[indeksModul(_modul)]!.materi.length;
  }

  int totalSemuaMateri() {
    int totalMateri = 0;
    for (var i = 0; i < _eBelajar.modul.length; i++) {
      totalMateri += _eBelajar.modul[indeksModul(i + 1)]!.materi.length;
    }
    return totalMateri;
  }

  int totalSemuaMateriSelesai(KontrolProgress kontrolProgress) {
    int totalMateriSelesai = 0;
    for (var i = 0; i < _eBelajar.modul.length; i++) {
      kontrolProgress.ambilStatusBelajar(i + 1).forEach((isi) => isi ? totalMateriSelesai++ : null);
    }
    return totalMateriSelesai;
  }

  int semuaMateriSelesai(int modul, KontrolProgress kontrolProgress) {
    final statusBelajar = kontrolProgress.progressBelajar;
    return statusBelajar[modul - 1];
  }

  int get totalModul => _eBelajar.modul.length;
  int totalMateri(int modul) => _eBelajar.modul[indeksModul(modul)]!.materi.length;

  int ambilJumlahGambar(int modul, int materi) {
    return _eBelajar.modul[indeksModul(modul)]!.materi[indeksMateri(materi)].gambar.length;
  }

  EMateriBelajar ambilMateri(int modul, int materi) { // harusnya getMateriSekarang()
    return _eBelajar.modul[indeksModul(modul)]!.materi[indeksMateri(materi)];
  }

  String indeksModul(int modul) => "modul_$modul";
  int indeksMateri(int materi) => materi - 1;

  // alat
  void aturModulSekarang(int modul) {
    _modul = modul;
    _materi = 0;
    notifyListeners();
  }

  void aturMateriSekarang(KontrolProgress kontrolProgress, int materi) {
    _materi = materi;
    kontrolProgress.naikkanProgressBelajar(_modul, _materi);
    notifyListeners();
  }

  void aturMateriSelanjutnya(KontrolProgress kontrolProgress, KontrolLog kontrolLog) {
    if (_materi < _eBelajar.modul[indeksModul(_modul)]!.materi.length) {
      _materi++;
      kontrolProgress.naikkanProgressBelajar(_modul, _materi);
      kontrolLog.catatLogBelajar(modul: _modul, materi: _materi);
      notifyListeners();
    }
  }

  void aturMateriSebelumnya() {
    if (_materi > 1) {
      _materi--;
      notifyListeners();
    }
  }

  // tutup apk || tutup menu
  void tutupMenuBelajar() {
    _modul = 0;
    _materi = 0;
  }

  void tutupMenuModul() {
    _modul = 0;
    _materi = 0;
  }
  void tutupMenuMateri() {
    _materi = 0;
  }
}