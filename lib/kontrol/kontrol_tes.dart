import 'package:belajar_isyarat/entitas/tes/e_soal_tes.dart';
import 'package:belajar_isyarat/kontrol/kontrol_log.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:flutter/foundation.dart';
// ======================== BELUM CEK, CEK DULU ===================
import '../entitas/tes/e_tes.dart';
import 'kontrol_database.dart';

class KontrolTes extends ChangeNotifier {
  int _modul = 0; // 1 sampai n. 0 artinya tidak aktif
  int _soal = 0; // 1 sampai n
  bool _tesSelesai = false;
  bool _menuSelesai = false;
  int _nilaiTes = 0;
  
  int _jawabanBenar = 0;
  int _totalSoal = 0;

  int _pilihanKotak = 0;
  List<dynamic> _susunanJawaban = [false];
  List<dynamic> _simpananJawaban = [];

  late ETes _eTes; //.modul<String,semuaSoal>.semuaSoal[ESoalTes].suara:String?,gambar:dynamic,pertanyaan:String,opsi[String]?,jawaban:dynamic,mode:ModeTes{"susun", "pilih", "hubungkan", "lengkapi", "artikan"}

  // ==== inisialisasi ====
  Future<bool> inis(KontrolDatabase kontrolDatabase, KontrolProgress kontrolProgress) async {
    final data = kontrolProgress.bahasaInggris
      ? await kontrolDatabase.ambilJson('tes_inggris')
      : await kontrolDatabase.ambilJson('tes_indo');

    _eTes = ETes.fromJson(data);

    notifyListeners();
    return true;
  }

  void bukaMenuTes(int modul, KontrolProgress kontrolProgress) {
    final semuaSoal = _eTes.modul[indeksModul(modul)]!.semuaSoal;
    _modul = modul;
    _soal = 1;
    _jawabanBenar = 0;
    _totalSoal = semuaSoal.length;
    _pilihanKotak = 0;
    _susunanJawaban = [false];
    _simpananJawaban = [];
    _nilaiTes = kontrolProgress.nilaiTes[modul - 1];
    _menuSelesai = false;
    _tesSelesai = false;

    // isi simpanan jawaban sesuai mode nya
    for (var i=0; i<semuaSoal.length; i++){
      if (semuaSoal[i].mode.name == "susun") {
        _simpananJawaban.add(semuaSoal[i].opsi);
        if (i == 0) {
          _susunanJawaban = semuaSoal[i].opsi;
        }
      } else if (semuaSoal[i].mode.name == "hubungkan") {
        _simpananJawaban.add([semuaSoal[i].opsi, semuaSoal[i].gambar]);
        if (i == 0) {
          _susunanJawaban = [semuaSoal[i].opsi, semuaSoal[i].gambar];
        }
      } else if (semuaSoal[i].mode.name == "lengkapi") {
        _simpananJawaban.add(semuaSoal[i].gambar);
        if (i == 0) {
          _susunanJawaban = [semuaSoal[i].gambar];
        }
      } else if (semuaSoal[i].mode.name == "artikan") {
        _simpananJawaban.add([]);
        for (var j = 0; j < semuaSoal[i].jawaban.length; j++) {
          _simpananJawaban[i].add(null);
        }
        if (i == 0) {
          _susunanJawaban = _simpananJawaban[i];
        }
      } else {
        _simpananJawaban.add(false);
      }
    }
    notifyListeners();
  }

  // ==== getter ====
  int get modul => _modul;
  int get soal => _soal;
  bool get tesSelesai => _tesSelesai;
  int get jawabanBenar => _jawabanBenar;
  int get totalSoal => _totalSoal;
  bool get menuSelesai => _menuSelesai;
  int get nilaiTes => _nilaiTes;
  List<int> semuaNilaiTes(KontrolProgress kontrolProgress) => kontrolProgress.nilaiTes;

  int get pilihanKotak => _pilihanKotak;
  String get susunanJawabanString => _susunanJawaban.first == false ? "0" : _susunanJawaban.first;
  List<dynamic> get susunanJawabanListDynamic => _susunanJawaban;
  List<String> get susunanJawabanListString {
    if (_susunanJawaban.isEmpty || _susunanJawaban.first == false) {
      return ["0"];
    }
    List<String> hasil = [];
    for (var isi in _susunanJawaban) {
      if (isi is String) {
        hasil.add(isi);
      } 
      else if (isi is List) {
        // flatten list satu level
        hasil.addAll(isi.map((e) => e.toString()));
      }
    }
    return hasil;
  }

  List<List<String>> get susunanJawabanListListString {
    if (_susunanJawaban.isEmpty || _susunanJawaban.first == false) {
      return [
        ["0"],
        ["0"]
      ];
    }

    List<List<String>> hasil = [];

    for (var isi in _susunanJawaban) {
      if (isi is String) {
        hasil.add([isi]);
      }
      else if (isi is List<String>) {
        hasil.add(isi);
      }
      else if (isi is List) {
        // pastikan semua elemen jadi string
        hasil.add(isi.map((e) => e.toString()).toList());
      }
    }

    return hasil;
  }

  List<dynamic> get simpananJawaban => _simpananJawaban;

  // rekursif: cek apakah satu nilai (String | bool | List | nested List) sudah "terisi"
  bool _isFilled(dynamic value) {
    if (value == null) return false;

    if (value is bool) {
      return value; // harus true
    }

    if (value is String) {
      return value.isNotEmpty; // kosong dianggap belum terisi
    }

    if (value is List) {
      if (value.isEmpty) return false; // list kosong dianggap belum terisi
      for (var item in value) {
        if (!_isFilled(item)) return false;
      }
      return true;
    }

    // untuk tipe lain (mis. int, double, Map) anggap terisi jika bukan null
    return true;
  }

  // cek apakah SEMUA soal pada _simpananJawaban sudah terisi (tidak ada null/false/empty)
  bool cekSemuaTesSelesai() {
    for (var isi in _simpananJawaban) {
      if (!_isFilled(isi)) return false;
    }
    return true;
  }

  // cek apakah SATU soal (nomor soal 1-based) sudah terisi
  bool cekSatuTesSelesai(int soal) {
    final idx = soal - 1;
    if (idx < 0 || idx >= _simpananJawaban.length) return false;
    return _isFilled(_simpananJawaban[idx]);
  }

  ESoalTes ambilSoalTes(int modul, int soal) {
    final indeksModul = "modul_$modul";
    final indeksSoal = soal - 1;

    return _eTes.modul[indeksModul]!.semuaSoal[indeksSoal];
  }

  double cekHasilNilai() {
    double hasil = _jawabanBenar / _totalSoal * 100;
    return hasil;
  }

  bool cekJawaban(int modul, int soal, dynamic jawaban) {
    final soalSekarang = _eTes.modul[indeksModul(modul)]!.semuaSoal[indeksSoal(soal)];
    final jawabanBenar = soalSekarang.mode.name == "artikan" ? soalSekarang.jawaban.map((j) => j.toString().toUpperCase()).toList() : soalSekarang.jawaban;

    return deepEquals(jawabanBenar, jawaban);
  }

  bool deepEquals(dynamic a, dynamic b) {
    // === 1. Null check ===
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;

    // === 2. Primitive check (String, num, bool) ===
    if (a is String && b is String) return a == b;
    if (a is num && b is num) return a == b;
    if (a is bool && b is bool) return a == b;

    // === 3. List check (rekursif) ===
    if (a is List && b is List) {
      if (a.length != b.length) return false;

      for (int i = 0; i < a.length; i++) {
        if (!deepEquals(a[i], b[i])) return false;
      }

      return true;
    }

    // === 4. Jika tipe beda, otomatis false ===
    return false;
  }

  bool cekListListPasangan(List<List<String>> user, List<List<String>> benar) {
    // --- Validasi awal ---
    if (user.length != 2 || benar.length != 2) return false;
    if (user[0].length != user[1].length) return false;
    if (benar[0].length != benar[1].length) return false;
    if (user[0].length != benar[0].length) return false;

    final n = user[0].length;

    // Bentuk set pasangan dari user
    final Set<String> pasanganUser = {};
    for (int i = 0; i < n; i++) {
      pasanganUser.add("${user[0][i]}::${user[1][i]}");
    }

    // Bentuk set pasangan dari jawaban benar
    final Set<String> pasanganBenar = {};
    for (int i = 0; i < n; i++) {
      pasanganBenar.add("${benar[0][i]}::${benar[1][i]}");
    }

    // Cocokkan: semua pasangan user harus ada di pasangan benar
    return pasanganUser.length == pasanganBenar.length &&
          pasanganUser.every((p) => pasanganBenar.contains(p));
  }

  List<List<String>> keListListString(List<dynamic> src) {
    final List<List<String>> hasil = [];

    for (var item in src) {
      if (item is List) {
        hasil.add(item.map((e) => e.toString()).toList());
      } else {
        hasil.add([item.toString()]);
      }
    }

    return hasil;
  }

  String indeksModul(int modul) => "modul_$modul";
  int indeksSoal(int soal) => soal - 1;

  // alat
  int aturPilihanKotak(int pilihan) {
    if (pilihan == _pilihanKotak) {
      _pilihanKotak = 0;
    } else {
      _pilihanKotak = pilihan;
    }
    notifyListeners();
    return _pilihanKotak;
  }
  
  void aturSusunanJawabanKosong() {
    _susunanJawaban.clear();
    _susunanJawaban.add(false);
    notifyListeners();
  }

  void aturSusunanJawabanString(String isi) {
    _susunanJawaban.clear();
    _susunanJawaban.add(isi);
    notifyListeners();
  }

  void aturSusunanJawabanListString(List<String> isi) {
    _susunanJawaban = isi;
    notifyListeners();
  }

  void aturSusunanJawabanListListString(List<List<String>> isi) {
    _susunanJawaban = isi;
    notifyListeners();
  }

  void aturSusunanJawabanListDynamic(List<dynamic> isi) {
    _susunanJawaban = isi;
    notifyListeners();
  }

  void jawabSoal({bool notify = false}) {
    final soal = _eTes.modul[indeksModul(_modul)]!.semuaSoal[indeksSoal(_soal)];

    // --- khusus mode 'pilih' --- 
    if (soal.mode.name == 'pilih') {
      // pastikan pilihanKotak valid (0 = tidak pilih)
      if (_pilihanKotak == 0) {
        _susunanJawaban = [false];
      } else {
        final pilihan = (soal.opsi.length >= _pilihanKotak)
            ? soal.opsi[_pilihanKotak - 1]
            : null;

        if (pilihan != null) {
          // bandingkan dengan elemen pertama _susunanJawaban (bukan dengan list)
          final current =
              (_susunanJawaban.isNotEmpty) ? _susunanJawaban[0] : false;
          if (current != pilihan) {
            _susunanJawaban = [pilihan];
          }
        }
      }
    }

    // --- jika ada perubahan dibanding simpanan, update simpanan ---
    final idx = indeksSoal(_soal);
    final sebelumnya = _simpananJawaban[idx];

    // bandingkan secara sederhana: jika berbeda, lakukan update
    // untuk mode 'pilih' simpan sebagai list atau false sesuai aturan
    if (!deepEquals(_susunanJawaban, sebelumnya)) {
      if (soal.mode.name == "pilih") {
        _simpananJawaban[idx] =
            (_susunanJawaban.isNotEmpty && _susunanJawaban[0] != false)
                ? [_susunanJawaban[0]]
                : false;
      } else {
        _simpananJawaban[idx] = _susunanJawaban;
      }
    }

    // --- notify hanya jika diminta eksplisit ---
    if (notify) {
      notifyListeners();
    }
  }

  void ajukanTes(KontrolProgress kontrolProgress, KontrolLog kontrolLog) {
    if (!cekSemuaTesSelesai()) {
      return;
    }
    _tesSelesai = true;
    final semuaSoal = _eTes.modul[indeksModul(_modul)]!.semuaSoal;

    for (var i = 0; i < semuaSoal.length; i++) {
      final jawabanUser = _simpananJawaban[i];
      final benar = semuaSoal[i].mode.name == "hubungkan" 
        ? cekListListPasangan(keListListString(jawabanUser), keListListString(semuaSoal[i].jawaban)) 
        : cekJawaban(_modul, i + 1, jawabanUser);

      if (benar) {
        _jawabanBenar++;
      }
    }
    final nilai = cekHasilNilai().round();
    _nilaiTes = nilai;
    kontrolProgress.naikkanNilaiTes(_modul, nilai);
    kontrolLog.catatLogTes(modul: _modul, skor: nilai);
    _menuSelesai = true;
    notifyListeners();
  }

  void aturSoalSelanjutnya() {
    if (_soal < _eTes.modul[indeksModul(_modul)]!.semuaSoal.length) {
      jawabSoal();
      _soal++;
      final soal = _eTes.modul[indeksModul(_modul)]!.semuaSoal[indeksSoal(_soal)];
      _susunanJawaban = _simpananJawaban[_soal - 1] is List ? _simpananJawaban[_soal - 1] : [_simpananJawaban[_soal - 1]];
      _pilihanKotak = soal.mode.name == "pilih" ? (_susunanJawaban[0] != false ? soal.opsi.indexOf(_susunanJawaban[0]) + 1 : 0) : 0;
      notifyListeners();
      print("$_susunanJawaban || $_simpananJawaban || $_pilihanKotak");
    }
  }

  void aturSoalSebelumnya() {
    if (_soal > 1) {
      jawabSoal();
      _soal--;
      final soal = _eTes.modul[indeksModul(_modul)]!.semuaSoal[indeksSoal(_soal)];
      _susunanJawaban = _simpananJawaban[_soal - 1] is List ? _simpananJawaban[_soal - 1] : [_simpananJawaban[_soal - 1]];
      _pilihanKotak = soal.mode.name == "pilih" ? (_susunanJawaban[0] != false ? soal.opsi.indexOf(_susunanJawaban[0]) + 1 : 0) : 0;
      notifyListeners();
      print("$_susunanJawaban || $_simpananJawaban || $_pilihanKotak");
    }
  }

  void masukMenuSelesai() {
    _menuSelesai = true;
    notifyListeners();
  }

  void keluarMenuSelesai() {
    _menuSelesai = false;
    notifyListeners();
  }

  // tutup apk || tutup menu
  void tutupMenuTes(int modul) {
    _modul = modul;
    _soal = 1;
    _tesSelesai = false;
    _menuSelesai = false;
    _jawabanBenar = 0;
    _totalSoal = 1;
    _susunanJawaban = [false];
    _simpananJawaban = [];
    _pilihanKotak = 0;
    notifyListeners();
  }
}