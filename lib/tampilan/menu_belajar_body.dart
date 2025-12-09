import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/kontrol/kontrol_belajar.dart';
import 'package:belajar_isyarat/kontrol/kontrol_database.dart';
import 'package:belajar_isyarat/kontrol/kontrol_log.dart';
import 'package:belajar_isyarat/kontrol/kontrol_menu.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/kontrol/kontrol_tes.dart';
import 'package:belajar_isyarat/tampilan/card_statis.dart';
import 'package:belajar_isyarat/tampilan/lingkaran.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuBelajarMenuBody extends StatefulWidget {
  const MenuBelajarMenuBody({super.key});

  @override
  State<MenuBelajarMenuBody> createState() => _MenuBelajarMenuBodyState();
}

class _MenuBelajarMenuBodyState extends State<MenuBelajarMenuBody> {
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
    final kBelajar = context.watch<KontrolBelajar>();
    final kProgress = context.read<KontrolProgress>();
    final kontrolMenu = context.read<KontrolMenu>();
    final kLog = context.read<KontrolLog>();
    final alat = context.read<AlatApp>();
    final kDatabase = context.read<KontrolDatabase>();

    final kBelajarProgressMateri = context.select<KontrolBelajar, int> (
      (k) => k.semuaMateriSelesai(kBelajar.modulSekarang, kProgress)
    );
    final kTesNilai = context.select<KontrolTes, List<int>>(
      (k) => k.semuaNilaiTes(kProgress)
    );
    final kBelajarMateriSelesai = context.select<KontrolBelajar, List<bool>>(
      (k) => k.ambilListMateriSelesai(kProgress)
    );

    final totalMateri = kBelajar.totalMateriSekarang;
    final nilai = kTesNilai[kBelajar.modulSekarang - 1];

    return Row(
        children: [
          alat.bangunTombolKembali(() => kontrolMenu.bukaMenu(0)),

          SizedBox(width: 20),
          Expanded(
            child: ScrollFade(
              controller: controller,
              child: Scrollbar(              // ← Scrollbar membungkus seluruh konten scroll
              controller: controller,
              thumbVisibility: true,
              thickness: 10,
              child: SingleChildScrollView( // ← scrollable utama
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // === KOLOM ATAS: Judul ===
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 120,
                        maxWidth: double.maxFinite
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: alat.kotakPutih,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: alat.boxShadow,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${alat.teksBelajarProgress(kProgress)}: ",
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: alat.teksKuning,
                                      shadows: alat.teksShadow,
                                      fontFamily: alat.judul
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      Text(
                                        "$kBelajarProgressMateri / $totalMateri",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: alat.teksKuning,
                                          shadows: alat.teksShadow,
                                          fontFamily: alat.judul
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: alat.bangunProgressBar(
                                          context: context, 
                                          progresss: kBelajarProgressMateri / totalMateri, 
                                          tinggi: 20
                                        )
                                      )
                                    ]
                                  )
                                  
                                ],
                              ),
                            ),
                            SizedBox(width: 10),

                            Expanded(
                              flex: 1,
                              child: Center(
                                child: CardStatis(
                                  lebar: 170,
                                  tinggi: 80,
                                  padding: 10,
                                  kotakWarna: alat.kotakUtama,
                                  isiTengah: true,
                                  pemisahGarisLuarUkuran: 5,
                                  pemisahGarisLuarWarna: nilai > 0 ? alat.teksPutihSedang : null,
                                  garisLuarUkuran: nilai > 0 ? 7 : 0,
                                  garisLuarWarna: nilai > 0 ? (nilai > 75 ? alat.benar : alat.netral) : null,
                                  tepiRadius: 10,
                                  judul: "${alat.teksBelajarTes(kProgress)} ${kBelajar.modulSekarang}",
                                  judulUkuran: 17,
                                  judulWarna: alat.teksPutihSedang,
                                  fontJudul: alat.judul,
                                  pakaiHover: true,
                                  pakaiKlik: true,
                                  padaHoverPemisahGarisLuarGradient: alat.terpilih,
                                  padaHoverAnimasi: padaHoverAnimasi1,
                                  padaKlikAnimasi: padaKlikAnimasi1,
                                  padaKlik: () {
                                    kontrolMenu.bukaMenu(3);
                                  },
                                  padaHoverBayanganPemisahGarisLuar: nilai > 0 ? null : alat.boxShadowHover,
                                  bayanganKotak: nilai > 0 ? null : alat.boxShadow,
                                  bayanganGarisLuar: nilai > 0 ? alat.boxShadow : null,
                                  padaHoverBayanganGarisLuar: nilai > 0 ? alat.boxShadowHover : null,
                                  tanda: nilai > 0 ? Lingkaran(
                                    besar: 30,
                                    warnaLingkaran: nilai > 75 ? alat.benar : alat.netral,
                                    warnaSimbolAngka: alat.teksPutihSedang,
                                    angka: nilai,
                                    besarGarisLuar: 7,
                                    warnaGarisLuar: alat.kotakPutih,
                                  ) : null
                                )
                              ),
                            ),
                          ]
                        )
                      ),
                    ),
                    SizedBox(height: 20),

                    // === KOLOM BAWAH: List modul ===
                    Center(
                      child: Wrap(
                        spacing: 13,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: List.generate(kBelajar.totalMateriSekarang, (i) {
                          final materi = kBelajar.ambilMateri(kBelajar.modulSekarang, i + 1);
                          final panjang = materi.gambar.length > 1;
                          final warnaKotak = alat.warnaWarnaKotak[i % 3];
                          final selesai = kBelajarMateriSelesai[i];

                          return CardStatis(
                            lebar: panjang ? 440 : 200,
                            tinggi: panjang ? 220 : 220,
                            padding: 8,
                            tepiRadius: 30,
                            kotakWarna: warnaKotak,
                            pemisahGarisLuarUkuran: 4,
                            pemisahGarisLuarWarna: selesai ? alat.kotakPutih : null,
                            garisLuarUkuran: 6,
                            garisLuarWarna: selesai ? alat.benar : null,
                            gambar: materi.gambar,
                            paddingGambar: 10,
                            tepiRadiusGambar: panjang ? 150 : 20,
                            warnaGambarColor: alat.kotakPutih,
                            pemisahGambar: Icon(
                              Icons.double_arrow_rounded,
                              color: alat.teksHitam,
                            ),
                            jarakGambarPemisah: 10,
                            besarPemisahGambar: 250,
                            judul: materi.judul,
                            judulUkuran: panjang ? 15 : 25,
                            fontJudul: alat.judul,
                            judulWarna: alat.teksPutihSedang,
                            isiTengah: true,
                            pakaiHover: true,
                            pakaiKlik: true,
                            padaHoverAnimasi: padaHoverAnimasi1,
                            padaHoverPemisahGarisLuarWarna: selesai ? null : alat.kotakPutih,
                            padaHoverPemisahGarisLuarGradient: selesai ? alat.terpilih : null,
                            padaHoverGarisLuarGradient: selesai ? null : alat.terpilih,
                            padaKlikAnimasi: padaKlikAnimasi1,
                            susunGambarTeksBaris: Axis.vertical,
                            padaKlik: () {
                              kBelajar.aturMateriSekarang(kProgress, i + 1, kLog, kDatabase);
                              kLog.catatLogBelajar(modul: kBelajar.modulSekarang, materi: i + 1);
                              kontrolMenu.bukaMenu(2);
                            },
                            padaHoverBayanganGarisLuar: alat.boxShadowHover,
                            bayanganKotak: alat.boxShadow,
                            tanda: selesai ? Lingkaran(
                              besar: 40, 
                              besarGarisLuar: 7, 
                              warnaGarisLuar: alat.kotakPutih, 
                              benarSalahNetral: 1, 
                              warnaLingkaran: alat.benar, 
                              warnaSimbolAngka: alat.teksPutihSedang,
                            ):null,
                          );
                        })
                      )
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              )
            )
          )
        )
      ]
    );
  }
}

class MenuBelajarMateriBody extends StatelessWidget {
  const MenuBelajarMateriBody({super.key});

  @override
  Widget build(BuildContext context) {
    final kontrolMenu = context.read<KontrolMenu>();
    final kBelajar = context.watch<KontrolBelajar>(); //
    final materi = kBelajar.modulSekarang == 0 || kBelajar.materiSekarang == 0
      ? kBelajar.ambilMateri(1, 1)
      : kBelajar.ambilMateri(kBelajar.modulSekarang, kBelajar.materiSekarang);
    final alat = context.read<AlatApp>();

    final panjang = materi.gambar.length > 1;

    return alat.bangunAnimasi(
          key: ValueKey(kBelajar.materiSekarang) ,
          child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        alat.bangunTombolKembali(
          () {
            kBelajar.tutupMenuMateri();
            kontrolMenu.bukaMenu(1);
          }
        ),
        SizedBox(width: 10),
        
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                CardStatis(
                  isiTengah: true,
                  lebar: null,
                  tinggi: null,
                  kotak: true,
                  padding: 20,
                  tepiRadius: 35,
                  kotakGradient: alat.warnaHeader,
                  gambar: materi.gambar,
                  besarGambar: null,
                  warnaGambarColor: alat.kotakPutih,
                  tepiRadiusGambar: panjang ? 150 : 20,
                  susunGambarTeksBaris: Axis.vertical,
                  bayanganKotak: alat.boxShadow,
                  pemisahGambar: Icon(
                    Icons.double_arrow_rounded,
                    color: alat.teksHitam,
                  ),
                  jarakGambarPemisah: 10,
                  besarPemisahGambar: 250,
                ),

                SizedBox(width: 10),

                Expanded(
                  child:  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsetsGeometry.only(right: 20, left: 40, bottom: 15, top: 15),
                          child: Center(
                            child: CardStatis(
                              lebar: null,
                              tinggi: null,
                              isiTengah: true,
                              tepiRadius: 30,
                              kotakWarna: alat.kotakUtama,
                              pemisahGarisLuarUkuran: 10,
                              pemisahGarisLuarWarna: alat.kotakPutih,
                              judul: materi.judul,
                              bayanganJudul: alat.judulShadow,
                              judulUkuran: 27,
                              judulWarna: alat.teksPutihSedang,
                              fontJudul: alat.judul,
                              bayanganKotak: alat.boxShadow,
                              bayanganPemisahGarisLuar: alat.boxShadow,
                            ),
                          ),
                        )
                      ),
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20,top: 20, bottom: 20),
                          child: CardStatis(
                            lebar: null,
                            tinggi: null,
                            isiTengah: true,
                            padding: 7,
                            tepiRadius: 10,
                            kotakWarna: alat.kotakPutih,
                            bayanganKotak: alat.boxLightTepiKiriAtas,
                            pemisahGarisLuarUkuran: 4,
                            pemisahGarisLuarWarna: alat.teksHitam,
                            garisLuarUkuran: 7,
                            garisLuarWarna: alat.kotakUtama,
                            teks: materi.penjelasan,
                            bayanganTeks: alat.teksShadow,
                            teksUkuran: 27,
                            teksWarna: alat.teksKuning,
                            fontTeks: alat.teks,
                            bayanganGarisLuar: alat.boxShadow,
                            clipEdgeKotak: [
                              false,
                              true,
                              false
                            ],
                            teksRataKiriKanan: true,
                            
                          ),
                        )
                      )
                    ]
                  )
                ),
              ],
            )
          )
        )
      ],
    ));
  }
}