import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/tampilan/header_footer.dart';
import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/tampilan/menu_pengaturan_body.dart';
import 'package:belajar_isyarat/tampilan/menu_tentang_body.dart';
import 'package:belajar_isyarat/tampilan/percobaan.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../kontrol/kontrol_menu.dart';
import 'menu_utama_body.dart';
import 'menu_belajar_body.dart';
import 'menu_tes_body.dart';
import 'menu_kuis_body.dart';
import 'menu_progress_body.dart';

class MenuRoot extends StatefulWidget {
  const MenuRoot({super.key});

  @override
  State<MenuRoot> createState() => _MenuRootState();
}

class _MenuRootState extends State<MenuRoot> {
  // halaman yang harus lazy-load
  Widget? _belajarMenu;
  Widget? _belajarMateri;
  Widget? _tesMenu;
  Widget? _tesSoal;
  Widget? _kuisSoal;
  late bool bahasaInggris;
  late bool temp;

  @override
  void initState() {
    super.initState();
    temp = bahasaInggris = context.read<KontrolProgress>().bahasaInggris;
  }

  @override
  Widget build(BuildContext context) {
    final kontrolMenu = context.watch<KontrolMenu>();
    final alat = context.read<AlatApp>();

    if (temp != bahasaInggris) {
      _belajarMenu = null;
      _belajarMateri = null;
      _tesMenu = null;
      _tesSoal = null;
      _kuisSoal = null;
      temp = bahasaInggris;
    }

    // Lazy init
    switch (kontrolMenu.halaman) {
      case 1:
        _belajarMenu ??= MenuBelajarMenuBody();
        break;
      case 2:  
        _belajarMateri ??= MenuBelajarMateriBody();
        break;
      case 3:  
        _tesMenu ??= MenuTesMenuBody();
        break;
      case 4:
        _tesSoal ??= MenuTesSoalBody();
        break;
      case 6:
        _kuisSoal ??= MenuKuisSoalBody();
        break;
    }

    return Container(
          decoration: BoxDecoration(
            gradient: alat.gradientLatarBelakang,
            image: DecorationImage(
              image: AssetImage("lib/database/gambar/bg_pattern.png"),
              fit: BoxFit.cover,
              opacity: 0.15,        // atur transparansi gambar
            ),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: Header(),

              body: SafeArea(
                bottom: true,
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: IndexedStack(
                    index: kontrolMenu.halaman,
                    children: [
                      MenuUtamaBody(),        // 0 (static)
                      _belajarMenu ?? SizedBox.shrink(),  // 1 (lazy)
                      _belajarMateri ?? SizedBox.shrink(), // 2 (lazy)
                      _tesMenu  ?? SizedBox.shrink(),      // 3 (lazy)
                      _tesSoal ?? SizedBox.shrink(), // 4 (lazy)
                      MenuKuisMenuBody(),     // 5 (static)
                      _kuisSoal ?? SizedBox.shrink(), // 6 (lazy)
                      MenuProgressBody(),     // 7 (static)
                      MenuTentangBody(),      // 8 (static)
                      MenuPengaturanBody(refresh: (bahasaInggris) => setState(() {bahasaInggris = bahasaInggris;},))
                    ],
                  ),
                ),
              ),

              bottomNavigationBar: Builder(
                builder: (_) {
                  switch (kontrolMenu.halaman) {
                    case 2:
                      return FooterModel2(belajar: true);
                    case 4:
                      return FooterModel2(belajar: false);
                    case 6:
                      return FooterModel1();
                    default:
                      return SizedBox.shrink();
                  }
                },
              ),
            )
        );
  }
}