import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/tampilan/card_statis.dart';
import 'package:flutter/material.dart';
import '../kontrol/kontrol_progress.dart';
import 'package:provider/provider.dart';

class MenuProgressBody extends StatefulWidget {
  const MenuProgressBody({super.key});

  @override
  State<MenuProgressBody> createState() => _MenuProgressBodyState();
}

class _MenuProgressBodyState extends State<MenuProgressBody> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kProgressSkorKuis = context.select<KontrolProgress, int>(
      (k) => k.progressKuis
    );
    final kProgressNilaiTes = context.select<KontrolProgress, List<int>>(
      (k) => k.nilaiTes
    );
    final kProgressItemDipelajari = context.select<KontrolProgress, int>(
      (k) => k.ambilTotalStatusSemuaMateri()
    );
    final kProgressProgressMateri = context.select<KontrolProgress, double>(
      (k) => k.ambilProgressStatusSemuaMateri()
    );
    final kProgress = context.read<KontrolProgress>();
    final alat = context.read<AlatApp>();

    int jumlahLulusTes = 0;
    for (var nilai in kProgressNilaiTes) {
      if (nilai > 80) {
        jumlahLulusTes++;
      }
    };

    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: Scrollbar(              // ← Scrollbar membungkus seluruh konten scroll
        controller: controller,
        thumbVisibility: true,
        thickness: 10,
        child: SingleChildScrollView( // ← scrollable utama
          controller: controller,
          child: Column(
            children:[
              LayoutBuilder(builder: (context, c) {
                final maxWidth = c.maxWidth;

                return SizedBox(
                  width: maxWidth,
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: CardStatis(
                          padding: 10,
                          isiTengah: true,
                          kotakWarna: alat.kotak1,
                          tepiRadius: 10,
                          pemisahGarisLuarUkuran: 4,
                          pemisahGarisLuarWarna: alat.kotak2,
                          judul: "Item dipelajari:  ${kProgress.ambilTotalSemuaMateri()}/$kProgressItemDipelajari",
                          judulUkuran: 17,
                          fontJudul: alat.judul,
                          judulWarna: alat.teksKuning,
                          pakaiHover: true,
                          padaHoverAnimasi: padaHoverAnimasi1,
                        )
                      ),
                      SizedBox(width: 10),

                      Expanded(
                        child: CardStatis(
                          padding: 10,
                          isiTengah: true,
                          kotakWarna: alat.kotak2,
                          tepiRadius: 10,
                          pemisahGarisLuarUkuran: 4,
                          pemisahGarisLuarWarna: alat.kotak3,
                          judul: "Progress Belajar:  ${kProgressProgressMateri * 100}%",
                          judulUkuran: 17,
                          fontJudul: alat.judul,
                          judulWarna: alat.teksKuning,
                          pakaiHover: true,
                          padaHoverAnimasi: padaHoverAnimasi1,
                        )
                      ),
                      SizedBox(width: 10),
                      
                      Expanded(
                        child: CardStatis(
                          padding: 10,
                          isiTengah: true,
                          kotakWarna: alat.kotak3,
                          tepiRadius: 10,
                          pemisahGarisLuarUkuran: 4,
                          pemisahGarisLuarWarna: alat.kotak4,
                          judul: "Skor Kuis:  $kProgressSkorKuis",
                          judulUkuran: 17,
                          fontJudul: alat.judul,
                          judulWarna: alat.teksKuning,
                          pakaiHover: true,
                          padaHoverAnimasi: padaHoverAnimasi1,
                        )
                      ),
                      SizedBox(width: 10),
                      
                      Expanded(
                        child: CardStatis(
                          padding: 10,
                          isiTengah: true,
                          kotakWarna: alat.kotak4,
                          tepiRadius: 10,
                          pemisahGarisLuarUkuran: 5,
                          pemisahGarisLuarWarna: alat.kotak4,
                          judul: "Jumlah Tes Lulus:  $jumlahLulusTes / ${kProgressNilaiTes.length}",
                          judulUkuran: 17,
                          fontJudul: alat.judul,
                          judulWarna: alat.teksKuning,
                          pakaiHover: true,
                          padaHoverAnimasi: padaHoverAnimasi1,
                        )
                      )
                    ]
                  )
                );
              })
            ]
          ),
        ),
      )
    );
  }
}
