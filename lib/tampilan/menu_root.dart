import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/tampilan/header_footer.dart';
import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/tampilan/menu_pengaturan_body.dart';
import 'package:belajar_isyarat/tampilan/menu_tentang_body.dart';

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
  late bool bahasaInggris;
  late bool tempBahasa;
  late AlatApp alat;

  @override
  void initState() {
    super.initState();
    tempBahasa = bahasaInggris = context.read<KontrolProgress>().bahasaInggris;
    alat = context.read<AlatApp>();
  }

  Widget bangunHalaman(int index) {
    switch (index) {
      case 0: return alat.bangunAnimasi(child: MenuUtamaBody(), key: ValueKey(0));
      case 1: return alat.bangunAnimasi(child: MenuBelajarMenuBody(), key: ValueKey(1));
      case 2: return alat.bangunAnimasi(child: MenuBelajarMateriBody(), key: ValueKey(2));
      case 3: return alat.bangunAnimasi(child: MenuTesMenuBody(), key: ValueKey(3));
      case 4: return alat.bangunAnimasi(child: MenuTesSoalBody(), key: ValueKey(4));
      case 5: return alat.bangunAnimasi(child: MenuKuisMenuBody(), key: ValueKey(5));
      case 6: return alat.bangunAnimasi(child: MenuKuisSoalBody(), key: ValueKey(6));
      case 7: return alat.bangunAnimasi(child: MenuProgressBody(), key: ValueKey(7));
      case 8: return alat.bangunAnimasi(child: MenuTentangBody(), key: ValueKey(8));
      case 9: return alat.bangunAnimasi(child: MenuPengaturanBody(refresh: (bahasaInggris) => setState(() {bahasaInggris = bahasaInggris;},)), key: ValueKey(9));
      default: return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final kontrolMenu = context.watch<KontrolMenu>();
    final halaman = kontrolMenu.halaman;

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
              child: bangunHalaman(halaman)
              ),
            ),

          bottomNavigationBar: Builder(
            builder: (_) {
              switch (kontrolMenu.halaman) {
                case 2:
                  return alat.bangunAnimasi(child :FooterModel2(belajar: true), key: ValueKey(2));
                case 4:
                  return alat.bangunAnimasi(child :FooterModel2(belajar: false),key: ValueKey(4));
                case 6:
                  return alat.bangunAnimasi(child :FooterModel1(), key: ValueKey(6));
                default:
                  return SizedBox.shrink();
              }
            },
          ),
        )
    );
  }
} //flutter run -d windows -t lib/main.dart --verbose