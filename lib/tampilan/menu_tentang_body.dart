import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/kontrol/kontrol_belajar.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/kontrol/kontrol_tes.dart';
import 'package:belajar_isyarat/tampilan/card_statis.dart';
import 'package:belajar_isyarat/tampilan/lingkaran.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuTentangBody extends StatefulWidget {
  const MenuTentangBody({super.key});

  @override
  State<MenuTentangBody> createState() => _MenuTentangBodyState();
}

class _MenuTentangBodyState extends State<MenuTentangBody> {
  int nomorHalaman = 1;

  @override
  Widget build(BuildContext context) {
    final alat = context.read<AlatApp>();
    final kProgress = context.read<KontrolProgress>();

    Widget bangunHalaman(nomorHalaman) {
      if (nomorHalaman == 2) {
        return alat.bangunAnimasi(
          key: ValueKey(2),
          child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: alat.kotakPutih,
            borderRadius: BorderRadius.circular(10),
            border: BoxBorder.all(
              color: alat.kotakUtama,
              width: 5,
            ),
            boxShadow: alat.boxShadow
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              alat.bangunTeksGradien(
                teks: "${alat.teksTentangJudul1(kProgress)}:", 
                warna: alat.teksBiru, 
                font: alat.judul, 
                beratFont: FontWeight.bold, 
                ukuranFont: 32
              ),        
              SizedBox(height: 10),

              Text(
                alat.teksTentangAplikasi(kProgress),
                style: TextStyle(
                  fontSize: 17,
                  color: alat.teksHitam,
                  fontFamily: alat.teks,
                  letterSpacing: 0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              alat.bangunTeksGradien(
                teks: "${alat.teksTentangJudul2(kProgress)}:", 
                warna: alat.teksBiru, 
                font: alat.judul, 
                beratFont: FontWeight.bold, 
                ukuranFont: 32),
              SizedBox(height: 10),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "1. Satriya Justisia\n2. Vallentino\n3. Jona",
                    style: TextStyle(
                      fontSize: 17,
                      color: alat.teksHitam,
                      fontFamily: alat.teks,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "4. Nevan\n5. Ahmad\n6. Rio Devasya",
                    style: TextStyle(
                      fontSize: 17,
                      color: alat.teksHitam,
                      fontFamily: alat.teks,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.left,
                  )
                ]
              ),

              SizedBox(height: 20),
              alat.bangunTeksGradien(
                teks: "${alat.teksTentangJudul3(kProgress)}: 1.0.0", 
                warna: alat.teksBiru, 
                font: alat.judul, 
                beratFont: FontWeight.bold, 
                ukuranFont: 32
              ),
            ],
          ),
        ));
      } else {
        final kProgress = context.read<KontrolProgress>();
        final kBelajar = context.read<KontrolBelajar>();

        final kBelajarProgress = context.select<KontrolBelajar, int>(
          (k) => k.totalSemuaMateriSelesai(kProgress)
        );
        final kTesNilai = context.select<KontrolTes, List<int>>(
          (k) => k.semuaNilaiTes(kProgress)
        );
        final konklusi = kBelajarProgress != kBelajar.totalSemuaMateri()
          ? "belajar"
          : !kTesNilai.every((e) => e > 99)
            ? "tes"
            : "kuis";
        final pesanSaran = konklusi == "belajar"
          ? alat.teksSaranBelajar(kProgress)
          : konklusi == "tes"
            ? alat.teksSaranTes(kProgress)
            : alat.teksSaranKuis(kProgress);

        final judulSaran = konklusi == "belajar"
          ? alat.teksSaranBelajarJudul(kProgress)
          : konklusi == "tes"
            ? alat.teksSaranTesJudul(kProgress)
            : alat.teksSaranKuisJudul(kProgress);
        return alat.bangunAnimasi(
          key: ValueKey(1),
          child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: alat.kotakPutih,
            borderRadius: BorderRadius.circular(10),
            border: BoxBorder.all(
              color: alat.kotakUtama,
              width: 5,
            ),
            boxShadow: alat.boxShadow
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lingkaran(
                    besar: 70,
                    warnaLingkaran: konklusi == "belajar" ? alat.salah : konklusi == "tes" ? alat.netral : alat.benar,
                    warnaSimbolAngka: alat.teksPutihSedang,
                    benarSalahNetral: konklusi == "belajar" ? 2 : konklusi == "tes" ? 4 : 1,
                  ),
                  SizedBox(width: 30,),
                  Text(
                    judulSaran,
                    style:  TextStyle(
                      color: konklusi == "belajar" ? alat.salah : konklusi == "tes" ? alat.netral : alat.benar,
                      fontSize: 60,
                      fontFamily: alat.judul,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 80,),
              Text(
              pesanSaran,
              style:  TextStyle(
                color: konklusi == "belajar" ? alat.salah : konklusi == "tes" ? alat.netral : alat.benar,
                fontSize: 30,
                fontFamily: alat.judul,
                fontWeight: FontWeight.bold,
                letterSpacing: 0
              ),
              textAlign: TextAlign.center,
            ),
            ]
          )
        ));
      }
    }
    
    return Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardStatis(
                  lebar: 140,
                  tinggi: 55,
                  tepiRadius: 25,
                  isiTengah: true,
                  judul: alat.teksTentangTombol1(kProgress),
                  judulWarna: alat.teksTerangKuning,
                  judulUkuran: 17,
                  fontJudul: alat.judul,
                  kotakWarna: alat.kotakUtama,
                  pemisahGarisLuarUkuran: 5,
                  pemisahGarisLuarGradient: nomorHalaman == 1 ? alat.terpilih : null,
                  padaKlik: () {
                      nomorHalaman = 1;
                      setState(() {});
                  },
                  pakaiHover: true,
                  pakaiKlik: true,
                  padaHoverAnimasi: padaHoverAnimasi1,
                  padaKlikAnimasi: padaKlikAnimasi1,
                  bayanganKotak: nomorHalaman == 1 ? null : alat.boxShadow,
                  bayanganPemisahGarisLuar: nomorHalaman == 1 ? alat.boxShadow : null,
                  padaHoverBayanganKotak: nomorHalaman == 1 ? null : alat.boxShadowHover,
                  padaHoverBayanganPemisahGarisLuar: nomorHalaman == 1 ? alat.boxShadowHover : null,
                ),
                SizedBox(width: 30),
                CardStatis(
                  lebar: 140,
                  tinggi: 55,
                  tepiRadius: 25,
                  isiTengah: true,
                  judul: alat.teksTentangTombol2(kProgress),
                  judulWarna: alat.teksTerangKuning,
                  judulUkuran: 17,
                  fontJudul: alat.judul,
                  kotakWarna: alat.kotakUtama,
                  pemisahGarisLuarUkuran: 5,
                  pemisahGarisLuarGradient: nomorHalaman == 2 ? alat.terpilih : null,
                  padaKlik: () {
                      nomorHalaman = 2;
                      setState(() {});
                  },
                  pakaiHover: true,
                  pakaiKlik: true,
                  padaHoverAnimasi: padaHoverAnimasi1,
                  padaKlikAnimasi: padaKlikAnimasi1,
                  bayanganKotak: nomorHalaman == 2 ? null : alat.boxShadow,
                  bayanganPemisahGarisLuar: nomorHalaman == 2 ? alat.boxShadow : null,
                  padaHoverBayanganKotak: nomorHalaman == 2 ? null : alat.boxShadowHover,
                  padaHoverBayanganPemisahGarisLuar: nomorHalaman == 2 ? alat.boxShadowHover : null,
                ),
              ]
            ),
          ),
          Expanded(
            flex: 12,
            child: bangunHalaman(nomorHalaman)
          ),
        ]
    );
  }
}