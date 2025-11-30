import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/kontrol/kontrol_menu.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/tampilan/card_statis.dart';
import 'package:belajar_isyarat/tampilan/soal_model.dart';
import 'package:belajar_isyarat/kontrol/kontrol_kuis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuKuisMenuBody extends StatelessWidget {
  const MenuKuisMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    final kProgressProgressKuis = context.select<KontrolProgress, int> (
      (k) => k.progressKuis
    );
    final kMenu = context.read<KontrolMenu>();
    final alat = context.read<AlatApp>();

    return Padding (
      padding: const EdgeInsets.all(20),
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: alat.kotakUtama,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: alat.kotakPutih,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  "Menu Kuis",
                  style: TextStyle(
                    fontFamily: alat.judul,
                    color: alat.teksKuning,
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                
                Text(
                  "Kuis ini opsional dan tidak akan mempengaruhi progress belajar anda,\n "
                  "tetapi akan menambah skor kuis anda. Sangat disarankan untuk menguji kemampuan!",
                  style: TextStyle(
                    fontFamily: alat.teks,
                    fontSize: 20,
                    color: alat.teksHitam
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Skor Anda:   ",
                      style: TextStyle(
                        fontFamily: alat.teks,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: alat.teksKuning
                      ),
                    ),
                    alat.bangunTeksGradien(
                      font: alat.teks,
                      teks: kProgressProgressKuis.toString(),
                      ukuranFont: 27,
                      beratFont: FontWeight.bold,
                      warna: alat.progress
                    )
                  ],
                ),
                
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CardStatis(
                      lebar: 120,
                      tinggi: 80,
                      padding: 10,
                      isiTengah: true,
                      pemisahGarisLuarUkuran: 7,
                      judul: "Mulai",
                      judulUkuran: 32,
                      judulWarna: alat.teksPutihSedang,
                      fontJudul: alat.judul,
                      kotakGradient: alat.terpilih,
                      tepiRadius: 10,
                      pakaiKlik: true,
                      pakaiHover: true,
                      padaHoverPemisahGarisLuarWarna: alat.kotakUtama,
                      padaHoverAnimasi: padaHoverAnimasi1,
                      padaKlikAnimasi: padaKlikAnimasi1,
                      padaKlik: () {
                        kMenu.bukaMenu(4);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10)
              ]
            ),
          ),
        ),
      )
    );
  }
}

class MenuKuisSoalBody extends StatelessWidget {
  const MenuKuisSoalBody({super.key});

  @override
  Widget build(BuildContext context) {
    final kKuisSoal = context.select<KontrolKuis, int>(
      (k) => k.ambilAwalAntrianKuis
    );
    final kKuis = context.read<KontrolKuis>();

    final soal = kKuis.ambilKuis(kKuisSoal);

    switch (soal.mode.index) {
      case 0: 
        return SoalModel1(
          penjelas: soal.pertanyaan,
          gambarSoal: soal.gambar as List<String>,
          gambarJawaban: soal.opsi as List<String>,
          tes: false,
        );
      case 1:
        return SizedBox.shrink();
      case 2:
        return SizedBox.shrink();
      case 3:
        return SizedBox.shrink();
      case 4:
        return SizedBox.shrink();
      default:
        return SizedBox.shrink();
    }
  }
}