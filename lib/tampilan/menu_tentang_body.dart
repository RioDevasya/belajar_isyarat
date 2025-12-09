import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/kontrol/kontrol_belajar.dart';
import 'package:belajar_isyarat/kontrol/kontrol_log.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/kontrol/kontrol_tes.dart';
import 'package:belajar_isyarat/kontrol/sistem_saran.dart';
import 'package:belajar_isyarat/tampilan/card_statis.dart';
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
        return Container(
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
                "Aplikasi Belajar Isyarat ini dibuat untuk membantu pengguna mempelajari bahasa isyarat\n dengan cara yang interaktif dan menyenangkan.\n "
                "Dengan berbagai modul pembelajaran, kuis, dan fitur pelacakan progres, \npengguna dapat belajar sesuai kecepatan mereka sendiri.",
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
        );
      } else {
        final kLog = context.read<KontrolLog>();
        final kTes = context.read<KontrolTes>();
        final kProgress = context.read<KontrolProgress>();
        final kBelajar = context.read<KontrolBelajar>();
        final saran = SistemSaran(
          logList: kLog.ambilListLogSync(), 
          nilaiTes: kTes.semuaNilaiTes(kProgress), 
          statusBelajar: kProgress.eProgressBelajar, 
          totalMateri: kBelajar.totalSemuaMateri(), 
          totalMateriSelesai: kBelajar.totalSemuaMateriSelesai(kProgress)
        );
        final hasil = saran.hasilAkhir();
        final konklusi = kBelajar.totalSemuaMateriSelesai(kProgress) != kBelajar.totalSemuaMateri()
          ? "belajar"
          : kTes.semuaNilaiTes(kProgress).every((e) => e > 99)
          ? "tes"
          : "kuis";
        final pesanSaran = konklusi == "belajar"
          ? alat.teksSaranBelajar(kProgress)
          : konklusi == "tes"
          ? alat.teksSaranTes(kProgress)
          : alat.teksSaranKuis(kProgress);
        return Container(
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
          child: Center(
            child: Text(
              pesanSaran,
              style:  TextStyle(
                color: konklusi == "belajar" || konklusi == "tes" ? alat.netral : alat.benar,
                fontSize: 30,
                fontFamily: alat.judul,
                fontWeight: FontWeight.bold,
                letterSpacing: 0
              ),
              textAlign: TextAlign.center,
            ),
          )
        );
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
                  lebar: 90,
                  tinggi: 40,
                  tepiRadius: 5,
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
                SizedBox(width: 10),
                CardStatis(
                  lebar: 90,
                  tinggi: 40,
                  tepiRadius: 5,
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

Widget buildSaranCard(Map<String, dynamic> hasil) {
  final tipe = hasil["tipe"]; // "kelebihan" atau "kekurangan"
  final kategori = hasil["kategori"];
  final poin = hasil["poin"];
  final pesan = hasil["pesan"];
  final rekomendasi = hasil["rekomendasi"];

  // warna tematik
  final bool isKelebihan = tipe == "kelebihan";
  final Color warnaUtama = isKelebihan ? Colors.green.shade600 : Colors.orange.shade700;
  final Color warnaLatar = isKelebihan ? Colors.green.shade50 : Colors.orange.shade50;

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: warnaLatar,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 3),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: warnaUtama,
              radius: 18,
              child: Icon(
                isKelebihan ? Icons.check_circle : Icons.warning_amber_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              isKelebihan ? "Kelebihan Kamu" : "Yang Perlu Ditingkatkan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: warnaUtama,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Pesan Utama
        Text(
          pesan,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 16),

        // Detail poin
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: warnaUtama.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Rincian Poin:", 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: warnaUtama,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Belajar:", style: TextStyle(fontSize: 14)),
                  Text("${poin["belajar"]}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tes:", style: TextStyle(fontSize: 14)),
                  Text("${poin["tes"]}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Kuis:", style: TextStyle(fontSize: 14)),
                  Text("${poin["kuis"]}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),

        // Rekomendasi (khusus kekurangan)
        if (!isKelebihan && rekomendasi != null) ...[
          const SizedBox(height: 16),
          Text(
            "Rekomendasi:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: warnaUtama,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            rekomendasi,
            style: const TextStyle(fontSize: 14),
          ),
        ]
      ],
    ),
  );
}