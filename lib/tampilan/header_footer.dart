import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/kontrol/kontrol_belajar.dart';
import 'package:belajar_isyarat/kontrol/kontrol_database.dart';
import 'package:belajar_isyarat/kontrol/kontrol_kuis.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/kontrol/kontrol_tes.dart';
import 'package:belajar_isyarat/tampilan/card_statis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../kontrol/kontrol_menu.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final kontrolMenu = context.watch<KontrolMenu>();
    final kontrolDatabase = context.read<KontrolDatabase>();
    final alatApp = context.read<AlatApp>();

    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        elevation: 1,
        titleSpacing: 10,
        flexibleSpace: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: alatApp.warnaHeader,
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: alatApp.kotakPutih,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: kontrolDatabase.ambilGambar("placeholder"),
                        ),
                        SizedBox(width: 10),

                        CardStatis(
                          lebar: 200,
                          tinggi: 40,
                          tepiRadius: 5,
                          isiTengah: true,
                          judul: "Belajar Isyarat",
                          judulUkuran: 20,
                          judulWarna: kontrolMenu.halaman == 8 ? alatApp.teksKuning : alatApp.teksPutihSedang,
                          fontJudul: alatApp.namaAplikasi,
                          teksTengah: true,
                          garisBawahJudul: true,
                          kotakWarna: kontrolMenu.halaman == 8 ? alatApp.kotakPutih : Colors.transparent,
                          pakaiKlik: true,
                          pakaiHover: true,
                          padaHoverAnimasi: padaHoverAnimasi2,
                          padaKlikAnimasi: padaKlikAnimasi1,
                          padaKlik: () {
                            kontrolMenu.bukaMenu(8);
                          },
                        )
                      ]
                    ),
                  ),
                ),
                
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CardStatis(
                        lebar: 100,
                        tinggi: 40,
                        tepiRadius: 5,
                        isiTengah: true,
                        judul: "Belajar",
                        judulUkuran: 20,
                        judulWarna: kontrolMenu.halaman == 0 
                          || kontrolMenu.halaman == 1 
                          || kontrolMenu.halaman == 2 
                          || kontrolMenu.halaman == 3 
                          || kontrolMenu.halaman == 4 ? alatApp.teksKuning : alatApp.teksPutihSedang,
                        fontJudul: alatApp.judul,
                        kotakWarna: kontrolMenu.halaman == 0 
                          || kontrolMenu.halaman == 1 
                          || kontrolMenu.halaman == 2 
                          || kontrolMenu.halaman == 3 
                          || kontrolMenu.halaman == 4 ? alatApp.kotakPutih : Colors.transparent,
                        pakaiKlik: true,
                        pakaiHover: true,
                        padaHoverAnimasi: padaHoverAnimasi2,
                        padaKlikAnimasi: padaKlikAnimasi1,
                        padaKlik: () {
                          kontrolMenu.bukaMenu(0);
                        },
                      ),
                      SizedBox(width: 10),

                      CardStatis(
                        lebar: 100,
                        tinggi: 40,
                        tepiRadius: 5,
                        isiTengah: true,
                        judul: "Kuis",
                        judulUkuran: 20,
                        judulWarna: kontrolMenu.halaman == 5 || kontrolMenu.halaman == 6 ? alatApp.teksKuning : alatApp.teksPutihSedang,
                        fontJudul: alatApp.judul,
                        kotakWarna: kontrolMenu.halaman == 5 || kontrolMenu.halaman == 6 ? alatApp.kotakPutih : Colors.transparent,
                        pakaiKlik: true,
                        pakaiHover: true,
                        padaHoverAnimasi: padaHoverAnimasi2,
                        padaKlikAnimasi: padaKlikAnimasi1,
                        padaKlik: () {
                          kontrolMenu.bukaMenu(5);
                        },
                      ),
                      SizedBox(width: 10),

                      CardStatis(
                        lebar: 100,
                        tinggi: 40,
                        tepiRadius: 5,
                        isiTengah: true,
                        judul: "Progress",
                        judulUkuran: 20,
                        judulWarna: kontrolMenu.halaman == 7 ? alatApp.teksKuning : alatApp.teksPutihSedang,
                        fontJudul: alatApp.judul,
                        kotakWarna: kontrolMenu.halaman == 7 ? alatApp.kotakPutih : Colors.transparent,
                        pakaiKlik: true,
                        pakaiHover: true,
                        padaHoverAnimasi: padaHoverAnimasi2,
                        padaKlikAnimasi: padaKlikAnimasi1,
                        padaKlik: () {
                          kontrolMenu.bukaMenu(7);
                        },
                      ),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CardStatis(
                        lebar: 100,
                        tinggi: 40,
                        tepiRadius: 5,
                        isiTengah: true,
                        judul: "Bantuan",
                        judulUkuran: 20,
                        judulWarna: kontrolMenu.halaman == 9 ? alatApp.teksKuning : alatApp.teksPutihSedang,
                        fontJudul: alatApp.judul,
                        kotakWarna: kontrolMenu.halaman == 9 ? alatApp.kotakPutih : Colors.transparent,
                        pakaiKlik: true,
                        pakaiHover: true,
                        padaHoverAnimasi: padaHoverAnimasi2,
                        padaKlikAnimasi: padaKlikAnimasi1,
                        padaKlik: () {
                          kontrolMenu.bukaMenu(9);
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// == FOOTER == MODEL 1 == KUIS
class FooterModel1 extends StatefulWidget {
  const FooterModel1({
    super.key,
  });

  @override
  State<FooterModel1> createState() => _FooterModel1State();
}

class _FooterModel1State extends State<FooterModel1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _scoreAnimation;
  late VoidCallback padaJawab;
  bool gagal = false;
  bool animasiSkor = false;
  int nilaiJawaban = 0;

  void trigger() async {
    setState(() => gagal = true);
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() => gagal = false);
  }
  void animasikanSkor() async {
    setState(() => animasiSkor = true);
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() => animasiSkor = false);
  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kKuisSkorKuis = context.select<KontrolKuis, int>(
      (k) => k.skorKuis
    );
    final kKuisSoalKuis = context.select<KontrolKuis, int>(
      (k) => k.ambilAwalAntrianKuis
    );
    final kKuis = context.read<KontrolKuis>();
    final kontrolProgress = context.read<KontrolProgress>();
    final alat = context.read<AlatApp>();

    padaJawab = () {
      if (kKuis.cekSatuKuisSelesai()) {
        nilaiJawaban = kKuis.ajukanKuis(kontrolProgress);
        animasikanSkor();
        kKuis.aturSoalSelanjutnya(kontrolProgress);
        print(kKuis.susunanJawabanListDynamic);
        print(kKuisSkorKuis);
      } else {
        trigger();
        print(kKuis.susunanJawabanListDynamic);
        print(kKuisSkorKuis);
      }
    };

    _scoreAnimation = IntTween(
      begin: kKuisSkorKuis - nilaiJawaban,
      end: kKuisSkorKuis,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        gradient: alat.warnaFooter,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Foto + skor animasi
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          const SizedBox(width: 16),

          // Animasi skor
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Text(
                "Skor: ${_scoreAnimation.value}${animasiSkor ? " + $nilaiJawaban" : ""}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),

          // Tombol Jawab
          CardStatis(
            lebar: 100, 
            tinggi: 40,
            isiTengah: true,
            padding: 10,
            tepiRadius: 10,
            pemisahGarisLuarUkuran: 3,
            pemisahGarisLuarWarna: gagal ? alat.salah : null,
            garisLuarUkuran: 10,
            judul: "Jawab",
            judulUkuran: 10,
            fontJudul: alat.judul,
            judulWarna: alat.teksPutihSedang,
            kotakGradient: alat.terpilih,
            pakaiKlik: true,
            pakaiHover: true,
            padaHoverAnimasi: padaHoverAnimasi2,
            padaHoverPemisahGarisLuarWarna: gagal ? null : alat.garisLuarHoverAbu,
            padaHoverGarisLuarWarna: gagal ? alat.garisLuarHoverAbu : null,
            padaKlikAnimasi: padaKlikAnimasi1,
            padaKlik: () {
              padaJawab();
            },
          ),
        ],
      ),
    );
  }
}

// == FOOTER == MODEL 2
class FooterModel2 extends StatefulWidget {
  final bool belajar;

  const FooterModel2({
    super.key,
    required this.belajar,
  });

  @override
  State<FooterModel2> createState() => _FooterModel2State();
}

class _FooterModel2State extends State<FooterModel2> {
  bool gagal = false;

  void trigger() async {
    setState(() => gagal = true);
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() => gagal = false);
  }

  @override
  Widget build(BuildContext context) {
    final kontrolProgress = context.read<KontrolProgress>();

    late int sekarang;
    late int total;
    late double progress;
    late VoidCallback padaSebelumnya;
    late VoidCallback padaSelanjutnya;
    late bool akhirSebelumnya;
    late bool akhirSelanjutnya;
    late String teksAkhirSelanjutnya;

    if (widget.belajar) {
      final kBelajar = context.read<KontrolBelajar>();
      final kMenu = context.read<KontrolMenu>();
      sekarang = context.select<KontrolBelajar, int>((k) => k.materiSekarang);
      total = kBelajar.totalMateriSekarang;
      progress = sekarang / total;

      padaSebelumnya = () {kBelajar.aturMateriSebelumnya();};
      padaSelanjutnya = () {
        if (sekarang == total) {
          kBelajar.tutupMenuMateri();
          kMenu.bukaMenu(1);
          return;
        }
        kBelajar.aturMateriSelanjutnya(kontrolProgress);
      };

      akhirSebelumnya = sekarang == 1 ? true : false;
      akhirSelanjutnya = sekarang == 0 ? true : false;
      teksAkhirSelanjutnya = sekarang == total ? "Keluar" : "Selanjutnya";
    } else {
      final kTes = context.read<KontrolTes>();
      sekarang = context.select<KontrolTes, int>((k) => k.soal);
      total = kTes.totalSoal;
      progress = sekarang / total;

      padaSebelumnya = () {
        if (sekarang == total && kTes.menuSelesai) {
          kTes.keluarMenuSelesai();
          return;
        }
        kTes.aturSoalSebelumnya();
      };
      padaSelanjutnya = () {
        if (!kTes.tesSelesai && sekarang == total) {
          kTes.jawabSoal(notify: true);
          if (kTes.cekSemuaTesSelesai()) {
            kTes.ajukanTes(kontrolProgress);
            return;
          } else {
            trigger();
            return;
          }
        }
        if (sekarang == total) {
          kTes.masukMenuSelesai();
          return;
        }
        kTes.aturSoalSelanjutnya();
      };

      akhirSebelumnya = sekarang == 1 ? true : false;
      akhirSelanjutnya = sekarang > total ? true : false;
      teksAkhirSelanjutnya = sekarang >= total ? "Kumpul Tes" : "Selanjutnya";
    }

    final alat = context.read<AlatApp>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        gradient: alat.warnaFooter,
      ),
      child: Row(
        children: [
          // Angka progress
          Text(
            "$sekarang/$total",
            style: TextStyle(
              fontFamily: alat.judul,
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: alat.teksPutihSedang,
            ),
          ),
          const SizedBox(width: 16),

          // Progress Bar
          Expanded(
            child: alat.bangunProgressBar(
              context: context,
              progress: progress, 
              tinggi: 20
            )
          ),
          const SizedBox(width: 16),

          // Tombol Sebelumnya
          CardStatis(
            lebar: 100, 
            tinggi: 40,
            isiTengah: true,
            padding: 10,
            tepiRadius: 10,
            pemisahGarisLuarUkuran: 3,
            judul: "Sebelumnya",
            judulUkuran: 10,
            fontJudul: alat.judul,
            judulGradient: alat.terpilih,
            kotakWarna: akhirSebelumnya ? alat.tidakAktif : alat.kotakPutih,
            pakaiKlik: true,
            pakaiHover: true,
            padaHoverAnimasi: padaHoverAnimasi2,
            padaHoverPemisahGarisLuarWarna: akhirSebelumnya ? null : alat.garisLuarHoverAbu,
            padaKlikAnimasi: padaKlikAnimasi1,
            padaKlik: () {
              padaSebelumnya();
            },
          ),
          const SizedBox(width: 10),

          // Tombol Selanjutnya
          CardStatis(
            lebar: 100, 
            tinggi: 40,
            isiTengah: true,
            padding: 10,
            tepiRadius: 10,
            pemisahGarisLuarUkuran: 3,
            pemisahGarisLuarWarna: gagal ? alat.salah : null,
            judul: teksAkhirSelanjutnya,
            judulUkuran: 10,
            fontJudul: alat.judul,
            judulWarna: alat.teksPutihSedang,
            kotakWarna: akhirSelanjutnya ? alat.tidakAktif : null,
            kotakGradient: akhirSelanjutnya ? null : alat.terpilih,
            pakaiKlik: true,
            pakaiHover: true,
            padaHoverAnimasi: padaHoverAnimasi2,
            padaHoverPemisahGarisLuarWarna: gagal ? null : (akhirSelanjutnya ? null : alat.garisLuarHoverAbu),
            padaHoverGarisLuarWarna: gagal ? alat.garisLuarHoverAbu : null,
            padaKlikAnimasi: padaKlikAnimasi1,
            padaKlik: () {
              padaSelanjutnya();
            },
          ),
        ],
      ),
    );
  }
}