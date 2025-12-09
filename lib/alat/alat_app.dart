import 'dart:math';

import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/tampilan/card_statis.dart';
import 'package:flutter/material.dart';

class AlatApp {
  // warna utama
  //-teksTerangKuning
  //-teksHitam
  Color get kotakUtama => const Color(0xFFf1b537);
  Color get kotakUtamaLain => const Color(0xFFf89a1c);
  Color get kotakPutih => const Color(0xFFf8f9fb);
  Color get kotakHitam => const Color(0xFF333333);

  Color get latarBelakang => const Color(0xFFf2f2f2);
  Color get latarBelakangPutih => const Color(0xFFeaeefb);
  Color get latarBelakangUngu => const Color(0xFFd6c5e8);

  Color get garisLuarHoverAbu => const Color(0xFFcccccc);

  Color get warnaKembaliBiru => const Color(0xFF9db8e7);
  Color get warnaKembaliUngu => const Color(0xFFb3a2e8);

  Color get hiasanKotak => const Color(0xFFf2f2f2);
  double get ukuranFooter => 75;

  // warna kotak
  Color get kotak1 => const Color(0xFFF9D260);
  Color get outline1 => const Color(0xFFFFF4C7);

  Color get kotak2 => const Color(0xFFF5B73A);
  Color get outline2 => const Color(0xFFFEEAB0);

  Color get kotak3 => const Color(0xFFF6BE55);
  Color get outline3 => const Color(0xFFFFF1BE);

  Color get kotak4 => const Color(0xFFEFB748);
  Color get outline4 => const Color(0xFFFBE8B2);

  Color get kotak5 => const Color(0xFFE6A93F);
  Color get outline5 => const Color(0xFFF8E3A8);

  Color get kotak6 => const Color(0xFFF7C44B);
  Color get outline6 => const Color(0xFFFFEFB0);

  // Warna header aplikasi
  Color get awalHeader => const Color(0xFFffc94d);
  Color get tengahHeader => const Color(0xFFffb732);
  Color get akhirHeader => const Color(0xFFe39f22);

  Color get latarBelakangProgressAbu => const Color(0xFFe5e5e5);

  // Warna biru
  Color get biruTerang => const Color(0xFF55d4f5);
  Color get unguTerang => const Color(0xFF8c6ff7);
  Color get biruGelap => const Color(0xFF47b5d1);
  Color get unguGelap => const Color(0xFF7844d1);

  // Warna teks
  Color get teksHitam => const Color(0xFF333333);
  Color get teksPutihTerang => const Color(0xFFfafafa);
  Color get teksPutihSedang => const Color(0xFFf8f9fb);
  Color get teksTerangKuning => const Color(0xFFfff9e5);
  Color get teksKuning => const Color(0xFFf1b537);
  Color get teksProgressBelum => const Color(0xFF6f6f6f);

  // Warna outline benar / salah
  Color get benar => const Color(0xFF4caf50); // hijau
  Color get salah => const Color(0xFFe53935); // merah
  Color get tidakAktif => const Color.fromARGB(255, 202, 214, 255);
  Color get netral => const Color(0xFF1E88E5);

  // Gradien Lain
  LinearGradient get teksBiru => LinearGradient(
    colors: [
      biruGelap,
      unguGelap
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  LinearGradient get progress => LinearGradient(
    colors: [
      biruTerang,
      unguTerang
    ]
  );
  LinearGradient get terpilih => LinearGradient(
    colors: [
      biruTerang,
      unguTerang
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  LinearGradient get gradientKembali => LinearGradient(
    colors: [
      warnaKembaliBiru,
      warnaKembaliUngu
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Gradien Latar dan Header
  LinearGradient get gradientLatarBelakang => LinearGradient(
    colors: [
      latarBelakangPutih,
      latarBelakangUngu
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  LinearGradient get warnaHeader => LinearGradient(
    colors: [
      awalHeader,
      tengahHeader,
      akhirHeader
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  LinearGradient get warnaFooter => LinearGradient(
    colors: [
      akhirHeader,
      tengahHeader,
      awalHeader,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Font
  String get judul => "Fredoka";
  String get teks => "Mulish";
  String get namaAplikasi => "Quicksand";

  // teks
  String teksAplikasi(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Sign Language" : "Belajar Isyarat";
  String teksHeaderBelajar(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Learn" : "Belajar";
  String teksHeaderKuis(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Quizez" : "Kuis";
  String teksHeaderProgres(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Progress" : "Progres";
  String teksHeaderPengaturan(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Setting" : "Pengaturan";

  String teksFooterKeluar(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Exit" : "Keluar";
  String teksFooterSelanjutnya(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Next" : "Selanjutnya";
  String teksFooterSebelumnya(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Before" : "Sebelumnya";
  String teksFooterKumpul(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Submit Test" : "Kumpul Tes";
  String teksFooterJawab(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Answer" : "Jawab";
  String teksFooterSkor(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Your Score" : "Skor Anda";

  String teksUtamaProgress(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Your Quiz Progress" : "Progress Kuis Anda";
  String teksUtamaNama(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Name" : "Nama";
  String teksUtamaSekolah(KontrolProgress kProgress) => kProgress.bahasaInggris ? "School" : "Sekolah";
  String teksUtamaJabatan(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Position" : "Jabatan";
  String teksUtamaProgressBar(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Your Total Learning Progress" : "Total Progres Belajar Anda";
  
  String teksBelajarProgress(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Your Progress in This Module" : "Progress Anda Pada Modul Ini";
  String teksBelajarTes(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Material Test" : "Tes Materi";
  
  String teksKuisJudul(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Quizez Menu" : "Menu Kuis";
  String teksKuisPenjelasan(KontrolProgress kProgress) => kProgress.bahasaInggris 
    ? "This quiz is optional and will not affect your learning progress,\n"
      "but it will increase your quiz score. It's highly recommended to test your skills!"
    : "Kuis ini opsional dan tidak akan mempengaruhi progress belajar anda,\n "
      "tetapi akan menambah skor kuis anda. Sangat disarankan untuk menguji kemampuan!";

  String teksTesJudul(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Test Menu" : "Menu Tes";
  String teksTesPenjelasan(KontrolProgress kProgress) => kProgress.bahasaInggris 
    ? "The test is the final step in completing the material progress.\n"
      "Your abilities will be tested here; you can take the test multiple times." 
    : "Tes adalah langkah terakhir untuk menyelesaikan progress materi.\n"
      "Kemampuan anda akan diuji disini, anda dapat mengerjakan tes berulang-kali";
  String teksTesNilai(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Your Test Scores" : "Nilai Tes Anda";

  String teksTesSelesaiJudul(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Test Score Menu" : "Menu Nilai Tes";
  String teksTesSelesaiPenjelas1(KontrolProgress kProgress) => kProgress.bahasaInggris 
    ? "Thanks for trying! It's okay, this is a great opportunity to learn again. Let's try again, you can definitely do better!" 
    : "Terima kasih sudah berusaha! Tidak apa-apa, ini kesempatan bagus untuk belajar lagi. Ayo coba sekali lagi, kamu pasti bisa semakin hebat!";

  String teksTesSelesaiPenjelas2(KontrolProgress kProgress) => kProgress.bahasaInggris 
    ? "Good! You almost did it! Just a little bit more and you'll reach your goal." 
    : "Bagus! Kamu sudah hampir berhasil! Sedikit lagi kamu pasti bisa mencapai target.";
  
  String teksTesSelesaiPenjelas3(KontrolProgress kProgress) => kProgress.bahasaInggris 
    ? "Great! You surpassed your goal! Keep it up, you're getting better!"
    : "Hebat! Kamu berhasil melewati target! Pertahankan, kamu makin pintar!";
  
  String teksTesSelesaiPenjelas4(KontrolProgress kProgress) => kProgress.bahasaInggris 
    ? "Amazing! You did a great job! Keep up the good work!"
    : "Luar biasa! Kamu mengerjakannya dengan sangat baik! Teruskan prestasimu!";

  String teksTombolMulai(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Start" : "Mulai";
  String teksTombolUlang(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Restart" : "Ulang";

  String teksProgresMateri(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Material Studied" : "Materi Dipelajari";
  String teksProgresTes(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Test Completed" : "Tes Selesai";
  String teksProgresSkor(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Total Quizez Score" : "Total Skor Kuis";
  String teksProgresLogAktivitas(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Activity Log" : "Log Aktivitas";
  String teksProgresModul(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Module" : "Modul";
  String teksProgresBelumLog(KontrolProgress kProgress) => kProgress.bahasaInggris ? "There is no activity yet" : "Belum ada aktivitas";
  String teksProgresBelumKuis(KontrolProgress kProgress) => kProgress.bahasaInggris ? "There is no Quizez data yet" : "Belum ada data Kuis";
  String teksProgresBelumTes(KontrolProgress kProgress) => kProgress.bahasaInggris ? "There is no test data yet" : "Belum ada data Tes";

  String teksTentangJudul1(KontrolProgress kProgress) => kProgress.bahasaInggris ? "About Application" : "Tentang Aplikasi";
  String teksTentangJudul2(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Application Developer" : "Pengembang Aplikasi";
  String teksTentangJudul3(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Application Version" : "Versi Aplikasi";
  String teksTentangTombol1(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Suggestion" : "Saran";
  String teksTentangTombol2(KontrolProgress kProgress) => kProgress.bahasaInggris ? "About" : "Tentang";

  String teksAturanProfil(KontrolProgress kProgress) => kProgress.bahasaInggris ? "User Profile" : "Profil Pengguna";
  String teksAturanSimpanAnonim(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Save As Anonymous" : "Simpan Sebagai Anonim";
  String teksAturanSimpan(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Save Profile" : "Simpan Profil";
  String teksAturanOpsional(KontrolProgress kProgress) => kProgress.bahasaInggris ? "Optional" : "Opsional";

  String teksSaranBelajar(KontrolProgress kProgress) => kProgress.bahasaInggris
    ? "Your learning of the material is not yet complete. It is recommended that you complete the learning before taking the test or quiz!"
    : "Pembelajaran materi anda masih belum selesai sepenuhnya. Direkomendasikan menyelesaikan pembelajaran sebelum melakukan tes ataupun kuis!";

  String teksSaranTes(KontrolProgress kProgress) => kProgress.bahasaInggris
    ? "You have completed the Lesson! but your Material Test is still incomplete. It is recommended that you complete the test before taking the quiz!"
    : "Anda telah menyelesaikan Pembelajaran! tetapi Tes Materi anda masih belum selesai sepenuhnya. Direkomendasikan menyelesaikan tes sebelum melakukan kuis!";

  String teksSaranKuis(KontrolProgress kProgress) => kProgress.bahasaInggris
    ? "You have completed the Learning and Material Test, you have passed, and that's great! Answering the Quiz is highly recommended to hone your skills, good luck!"
    : "Anda telah menyelesaikan Pembelajaran dan Tes Materi, anda telah lulus dan itu sangat bagus!. Menjawab Kuis sangat direkomendasikan untuk mengasah kemampuan ada, semoga sukses!";

  List<Pelajaran> itemBelajar(KontrolProgress kProgress) => [
    Pelajaran(kProgress.bahasaInggris ? "Numbers" : "Angka", "numbers"),
    Pelajaran(kProgress.bahasaInggris ? "Letters" : "Huruf", "abc-block"),
    Pelajaran(kProgress.bahasaInggris ? "Words" : "Kata", "word-blocks"),
  ];

  List<BoxShadow> get boxShadowHover => [
      // 1) Intense & small — tajam, dekat (foreground shadow)
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1), // intensitas tinggi
        offset: const Offset(6, 6),             // kanan-bawah kecil
        blurRadius: 6,                          // blur kecil = tajam
        spreadRadius: 1,                        // sedikit melebar
      ),

      // 2) Low intensity & large — lembut, menyebar (ambient shadow)
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04), // intensitas rendah
        offset: const Offset(14, 14),          // kanan-bawah lebih jauh
        blurRadius: 28,                        // blur besar = lembut
        spreadRadius: 0,                       // atau sedikit negatif jika mau
      ),
    ];

  List<BoxShadow> get boxShadow => [
      // 1) Intense & small — tajam, dekat (foreground shadow)
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1), // intensitas tinggi
        offset: const Offset(1.5, 1.5),             // kanan-bawah kecil
        blurRadius: 3,                          // blur kecil = tajam
        spreadRadius: 0.5,                        // sedikit melebar
      ),

      // 2) Low intensity & large — lembut, menyebar (ambient shadow)
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04), // intensitas rendah
        offset: const Offset(5.5, 5.5),          // kanan-bawah lebih jauh
        blurRadius: 7,                        // blur besar = lembut
        spreadRadius: 0,                       // atau sedikit negatif jika mau
      ),
    ];
  
  BoxShadow get pendukungBoxShadow => BoxShadow(
    color: Colors.black.withValues(alpha: 0.1), // intensitas tinggi
    offset: const Offset(1.5, 1.5),             // kanan-bawah kecil
    blurRadius: 4,                          // blur kecil = tajam
    spreadRadius: 0.5,                        // sedikit melebar
  );
  
  List<Shadow> get teksShadow => [
      // Bayangan tajam, kecil, intensitas tinggi
      Shadow(
        color: Colors.black.withValues(alpha: 0.15),
        offset: const Offset(2, 2),
        blurRadius: 4,
      ),
      // Bayangan lembut, besar, intensitas rendah
      Shadow(
        color: Colors.black.withValues(alpha: 0.04),
        offset: const Offset(5.5, 5.5),
        blurRadius: 7,
      ),
    ];

  List<BoxShadow> get boxLightOut => [
      // 1) Intense & small — tajam, dekat (foreground shadow)
      BoxShadow(
        color: kotakPutih,             // kanan-bawah kecil
        blurRadius: 10,                          // blur kecil = tajam
        spreadRadius: 10,                     // sedikit melebar
      ),

      // 2) Low intensity & large — lembut, menyebar (ambient shadow)
      BoxShadow(
        color: kotakPutih.withValues(alpha: 0.8),         // kanan-bawah lebih jauh
        blurRadius: 14,                        // blur besar = lembut
        spreadRadius: 25,                     // atau sedikit negatif jika mau
      ),
    ];

  List<BoxShadow> get boxLightTepiKiriAtas => [
            BoxShadow(
              color: kotakPutih,
              blurRadius: 14,
              spreadRadius: 2,
              offset: Offset(1.2, 1.2)
            ),
            BoxShadow(
              color: kotakPutih.withValues(alpha: 0.96),
              blurRadius: 5,
              spreadRadius: 7,
              offset: Offset(1.2, 1.2)
            ),
            BoxShadow(
              color: kotakPutih,
              blurRadius: 1,
              spreadRadius: 3,
              offset: Offset(3, 3)
            ),
          ];
  // ==== alat =====
  Widget bangunTombolKembali(VoidCallback fungsi) {
    return  CardStatis(
      lebar: 40,
      tinggi: null,
      isiTengah: true,
      padding: 4,
      tepiRadius: 25,
      kotakGradient: gradientKembali,
      pemisahGarisLuarUkuran: 4,
      judul: "<",
      judulWarna: teksPutihSedang,
      fontJudul: judul,
      pakaiKlik: true,
      pakaiHover: true,
      padaHoverAnimasi: padaHoverAnimasi1,
      padaHoverPemisahGarisLuarWarna: garisLuarHoverAbu,
      padaKlikAnimasi: padaKlikAnimasi1,
      padaKlik: fungsi,
      bayanganKotak: boxShadow,
      padaHoverBayanganPemisahGarisLuar: boxShadowHover,
    );
  }
  Widget bangunTeksGradien({
    required String teks, 
    required LinearGradient warna, 
    required String font, 
    FontWeight? beratFont, 
    required double ukuranFont  
  }) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return warna.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        teks,
        style: TextStyle(
          fontSize: ukuranFont,
          fontWeight: beratFont,
          fontFamily: font,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget bangunProgressBar({
  required BuildContext context,
  required double progresss,
  double? tinggi,
  double? garisLuar,
}) {
  // warna dan shadow bisa disesuaikan

  return LayoutBuilder(builder: (context, c) {
    final width = c.maxWidth.isFinite ? c.maxWidth : 0.0;
    final height = tinggi ?? c.maxHeight;
    final progressFinal = progresss.clamp(0.0, 1.0);

    // --- 1) Lapisan terluar gelap (membentuk tepi cekung) ---
    Widget base =  ClipRRect(
  borderRadius: BorderRadius.circular(15),   // radius sama!
  child: Container(
      padding: EdgeInsets.all(garisLuar ?? 4),
      decoration: BoxDecoration(
        color: Colors.black, // TEPI DALAM GELAP
        borderRadius: BorderRadius.circular(15),
      ),

      // --- 2) Lapisan dalam terang dengan SHADOW putih keluar ---
      child: Container(
        decoration: BoxDecoration(
          color: latarBelakangProgressAbu,
          borderRadius: BorderRadius.circular(13),

          // Shadow putih keluar → tampak seperti inner shadow
          boxShadow: [
            BoxShadow(
              color: latarBelakangProgressAbu,
              blurRadius: 14,
              spreadRadius: 2,
              offset: Offset(1.2, 1.2)
            ),
            BoxShadow(
              color: latarBelakangProgressAbu.withValues(alpha: 0.96),
              blurRadius: 5,
              spreadRadius: 7,
              offset: Offset(1.2, 1.2)
            ),
            BoxShadow(
              color: latarBelakangProgressAbu,
              blurRadius: 1,
              spreadRadius: 3,
              offset: Offset(3, 3)
            ),
          ],
        ),

        // --- 3) ISI STACK PROGRESS BAR ---
        child: Stack(
          children: [
            // Background track
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // Fill
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: width * progressFinal,
              height: height,
              decoration: BoxDecoration(
                gradient: progress,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 1,
                    spreadRadius: 0.2,
                    offset: Offset(2.5, 2)
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 7,
                    spreadRadius: 0,
                    offset: Offset(2.5, 2)
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    )
    );

    return base;
  });
}

  Widget bangunKetupat({
    required double ukuran,
    required Widget? isi,
    double segiEnam = 0,
    double tepiRadius = 0,

    // kotak inti
    Color? warnaKotak,
    LinearGradient? gradientKotak,

    double ukuranGarisLuar1 = 0, // Layer 3 → 2 → 1
    Color? warnaGarisLuar1,
    LinearGradient? gradienGarisLuar1,

    double ukuranGarisLuar2 = 0,
    Color? warnaGarisLuar2,
    LinearGradient? gradienGarisLuar2,

    double ukuranGarisLuar3 = 0,
    Color? warnaGarisLuar3,
    LinearGradient? gradienGarisLuar3,
  }) {
    Widget buildLayer({
      required double padding,
      required Color? color,
      required LinearGradient? gradient,
      required Widget child,
      BorderRadius? borderRadius
    }) {
      if (padding == 0) return child;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: gradient == null ? color : null,
          gradient: gradient,
          borderRadius: borderRadius
        ),
        child: child,
      );
    }

    Widget shapeWrapper(Widget child) {
      return ClipPath(
        clipper: segiEnam > 0 ? HexagonClipper() : DiamondClipper(),
        child: child,
      );
    }

    Widget innerBox = shapeWrapper(
      AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        width: ukuran,
        height: ukuran,
        decoration: BoxDecoration(
          color: gradientKotak == null ? warnaKotak : null,
          gradient: gradientKotak,
          borderRadius: BorderRadius.circular(tepiRadius)
        ),
        alignment: Alignment.center,
        child: isi,
      ),
    );

    Widget layer3 = buildLayer(
      padding: ukuranGarisLuar3,
      color: warnaGarisLuar3,
      gradient: gradienGarisLuar3,
      child: innerBox,
      borderRadius: BorderRadius.circular(tepiRadius + ukuranGarisLuar3 / 2)
    );

    Widget layer2 = buildLayer(
      padding: ukuranGarisLuar2,
      color: warnaGarisLuar2,
      gradient: gradienGarisLuar2,
      child: layer3,
      borderRadius: BorderRadius.circular(tepiRadius + ukuranGarisLuar3 / 2 + ukuranGarisLuar2/2)
    );

    Widget layer1 = buildLayer(
      padding: ukuranGarisLuar1,
      color: warnaGarisLuar1,
      gradient: gradienGarisLuar1,
      child: layer2,
      borderRadius: BorderRadius.circular(tepiRadius + ukuranGarisLuar3 / 2 + ukuranGarisLuar2/2 + ukuranGarisLuar1/2)
    );

    return layer1;
  }

  Widget bangunProgressBarPoin({
    required BuildContext context,
    double? lebar,
    double? tinggi,

    required int nomorSekarang,

    List<String>? isi,
    required List<bool> isiSelesai,
    TextStyle? styleIsi,
    double? jarakIsi,

    bool benarSalah = false,

    required double tinggiProgressBar,
    required double ukuranGarisLuarProgressBar,

    Function(int index)? padaKlik,
  }) {
    final total = isiSelesai.length;

    return LayoutBuilder(
      builder: (context, c) {
        final maxWidth = lebar ?? c.maxWidth;
        final maxHeight = tinggi ?? c.maxHeight;
        final ukuranKetupat = maxHeight;

        // Padding global untuk border ketupat
        const double g1 = 1;
        const double g2 = 2;
        const double g3 = 1;
        final totalGaris = g1 + g2 + g3;

        // Hitung ruang
        final totalLebarKetupat = (ukuranKetupat + totalGaris) * total;
        final ruangTersisa = maxWidth - totalLebarKetupat;

        final spacing = jarakIsi ?? (ruangTersisa / (total - 1)).clamp(0, 9999);

        // Hitung posisi progress bar:
        // Lebar progress harus berhenti di tengah ketupat nomorSekarang
        double lebarProgress = 0;

        // progress = semua ketupat sebelum + setengah ketupat saat ini
        if (nomorSekarang <= 1) {
          lebarProgress = (ukuranKetupat + totalGaris) / 2;
        } else {
          lebarProgress =
              (ukuranKetupat + totalGaris) * (nomorSekarang - 1) +
              spacing * (nomorSekarang - 1) +
              (ukuranKetupat + totalGaris) / 2;
        }

        // Ketupat builder
        final listKetupat = List.generate(total, (i) {
          final isNow = (i == nomorSekarang - 1);
          final isDone = isiSelesai[i];

          final warnaText = benarSalah
              ? teksPutihSedang
              : (isDone ? teksPutihSedang : teksProgressBelum);

          final kotak = benarSalah
              ? (isDone ? benar : salah)
              : (isDone ? null : kotakPutih);

          final gradientKotak = benarSalah
              ? null
              : (isDone ? progress : null);

          // Border logika
          final garis1 = latarBelakangProgressAbu;
          final garis2 = isNow
              ? (benarSalah
                  ? (isDone ? benar : salah)
                  : null)
              : null; // warna border 2 jika kotak sekarang
          final gradien2 = isNow ? (!benarSalah ? progress : null) : null;

          return GestureDetector(
            onTap: () => padaKlik?.call(i),
            child: bangunKetupat(
              ukuran: ukuranKetupat,
              isi: Text(
                isi != null ? isi[i] : (i + 1).toString(),
                style: styleIsi?.copyWith(color: warnaText) ??
                    TextStyle(
                      color: warnaText,
                      fontFamily: judul,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              tepiRadius: 4,
              warnaKotak: kotak,
              gradientKotak: gradientKotak,
              ukuranGarisLuar3: g3,
              warnaGarisLuar3: kotakPutih,
              ukuranGarisLuar2: g2,
              warnaGarisLuar2: garis2,
              gradienGarisLuar2: gradien2,
              ukuranGarisLuar1: g1,
              warnaGarisLuar1: garis1,
            )
          );
        });

        final arranged = <Widget>[];
        for (int i = 0; i < total; i++) {
          arranged.add(listKetupat[i]);
          if (i < total - 1) arranged.add(SizedBox(width: spacing));
        }

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Progress Bar di belakang
            Positioned(
              left: 0,
              child: bangunProgressBar(
                context: context,
                progresss: lebarProgress,
                tinggi: tinggiProgressBar,
                garisLuar: ukuranGarisLuarProgressBar,
              ),
            ),

            // Ketupat di depan
            Positioned.fill(
              child: IgnorePointer(
                child: Row(children: arranged),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget bangunMenuAtasSoal(List<String> gambarSoal, String penjelas) {
    final bukanGambar = gambarSoal.isNotEmpty ? gambarSoal.every((g) => g.startsWith("an") || g.startsWith("hu")) : false;
    final layout = gambarSoal.length > 1 ? Axis.vertical : Axis.horizontal;
    return Expanded(
      flex: gambarSoal.length > 1 ? 8 : 3,
      child: CardStatis(
        padding: 10,
        tepiRadius: 30,
        isiTengah: true,
        kotakGradient: warnaHeader,
        gambar: bukanGambar ? null : gambarSoal,
        gambarWidget: bukanGambar ? LayoutBuilder(builder: (context, c) {
          final maxWidth = c.maxWidth;
          final maxHeight = c.maxHeight;
          final size = min(maxHeight, maxWidth);

          if (gambarSoal.length > 1) {
            return Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: List.generate(
                  gambarSoal.length,
                  (i) {
                    return Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: kotakPutih,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: boxShadow,
                      ),
                      child: FittedBox(
                        child: bangunTeksGradien(
                          teks: gambarSoal[i].split("_").last, 
                          warna: terpilih, font: judul, ukuranFont: 10
                        )
                      )
                    );
                  }
                )
              )
            );
          }

          return CardStatis(
            kotak: true,
            tepiRadius: 10,
            kotakWarna: kotakPutih,
            gambarWidget: Expanded(
              child: FittedBox(
                child: bangunTeksGradien(
                  teks: gambarSoal[0].split("_").last, 
                  warna: terpilih, font: judul, ukuranFont: 10
                )
              ),
            ),
            bayanganKotak: boxShadow
          );
        }): null,
        paddingGambar: 10,
        tepiRadiusGambar: gambarSoal.length > 1 ? 90 : 10,
        warnaGambarColor: kotakPutih,
        jarakGambarPemisah: 10,
        pemisahGambar: Icon(
          Icons.double_arrow_rounded,
          color: teksHitam,
        ),
        besarPemisahGambar: 250,
        judul: penjelas,
        fontJudul: judul,
        judulUkuran: 27,
        judulWarna: teksPutihSedang,
        susunGambarTeksBaris: layout,
        bayanganKotak: boxShadow,
        bayanganJudul: teksShadow,
      ),
    );
  }
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final w = s.width;
    final h = s.height;
    return Path()
      ..moveTo(w / 2, 0)
      ..lineTo(w, h / 2)
      ..lineTo(w / 2, h)
      ..lineTo(0, h / 2)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size s) {
    final w = s.width;
    final h = s.height;
    return Path()
      ..moveTo(w * 0.25, 0)
      ..lineTo(w * 0.75, 0)
      ..lineTo(w, h * 0.5)
      ..lineTo(w * 0.75, h)
      ..lineTo(w * 0.25, h)
      ..lineTo(0, h * 0.5)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class Pelajaran {
  final String name;
  final String iconPath;

  Pelajaran(this.name, this.iconPath);
}