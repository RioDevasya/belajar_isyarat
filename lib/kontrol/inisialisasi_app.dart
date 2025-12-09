import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/kontrol/kontrol_log.dart';
import 'package:flutter/material.dart';

import 'kontrol_database.dart';
import 'kontrol_progress.dart';
import 'kontrol_belajar.dart';
import 'kontrol_tes.dart';
import 'kontrol_kuis.dart';
import 'kontrol_menu.dart';

class InisialisasiApp with ChangeNotifier {
  late final KontrolDatabase kontrolDatabase;
  late final KontrolProgress kontrolProgress;
  late final KontrolLog kontrolLog;
  late final KontrolBelajar kontrolBelajar;
  late final KontrolTes kontrolTes;
  late final KontrolKuis kontrolKuis;
  late final KontrolMenu kontrolMenu;
  late final AlatApp alatApp;

  String status = "Memulai...";
  int langkah = 0;
  int total = 5; // jumlah kontrol

  void _update(String pesan) {
    status = pesan;
    langkah++;
    notifyListeners();
  }

  Future<bool> inis() async {
    kontrolDatabase = KontrolDatabase();
    kontrolProgress = KontrolProgress();
    kontrolLog = KontrolLog();
    kontrolBelajar = KontrolBelajar();
    kontrolTes = KontrolTes();
    kontrolKuis = KontrolKuis();
    kontrolMenu = KontrolMenu();
    alatApp = AlatApp();

    bool ok1 = await kontrolLog.inis(kontrolDatabase);
    _update("siap Log...");

    bool ok2 = await kontrolProgress.inis(kontrolDatabase);
    _update("siap Progress...");

    bool ok3 = await kontrolBelajar.inis(kontrolDatabase, kontrolProgress);
    _update("siap Belajar...");

    bool ok4 = await kontrolTes.inis(kontrolDatabase, kontrolProgress);
    _update("siap Tes...");

    bool ok5 = await kontrolKuis.inis(kontrolDatabase, kontrolProgress);
    _update("siap Kuis...");

  return ok1 && ok2 && ok3 && ok4 && ok5;
  }
}