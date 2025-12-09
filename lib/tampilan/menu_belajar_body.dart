import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:belajar_isyarat/kontrol/kontrol_belajar.dart';
import 'package:belajar_isyarat/kontrol/kontrol_log.dart';
import 'package:belajar_isyarat/kontrol/kontrol_menu.dart';
import 'package:belajar_isyarat/kontrol/kontrol_progress.dart';
import 'package:belajar_isyarat/tampilan/card_statis.dart';

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

    final kBelajarProgressMateri = context.select<KontrolBelajar, int> (
      (k) => k.semuaMateriSelesai(kBelajar.modulSekarang, kProgress)
    );

    final totalMateri = kBelajar.totalMateriSekarang;

    return Row(
        children: [
          alat.bangunTombolKembali(() => kontrolMenu.bukaMenu(0)),

          SizedBox(width: 20),
          Expanded(
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
                        borderRadius: BorderRadius.circular(10),
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
                                    color: alat.teksKuning
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
                                pemisahGarisLuarUkuran: 7,
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
                                padaHoverBayanganGarisLuar: alat.boxShadowHover,
                                bayanganKotak: alat.boxShadow,
                              )
                            ),
                          ),
                        ]
                      )
                    ),
                  ),
                  SizedBox(height: 10),

                  // === KOLOM BAWAH: List modul ===
                  Center(
                    child: Wrap(
                      spacing: 13,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: List.generate(kBelajar.totalMateriSekarang, (i) {
                        final materi = kBelajar.ambilMateri(kBelajar.modulSekarang, i + 1);
                        final panjang = materi.gambar.length > 1;

                        return CardStatis(
                          lebar: panjang ? 320 : 150,
                          tinggi: panjang ? 220 : 180,
                          padding: 5,
                          tepiRadius: 10,
                          kotakWarna: alat.kotak1,
                          pemisahGarisLuarUkuran: 3,
                          garisLuarUkuran: 4,
                          gambar: materi.gambar,
                          paddingGambar: 10,
                          tepiRadiusGambar: 10,
                          warnaGambarColor: alat.kotakPutih,
                          judul: materi.judul,
                          judulUkuran: panjang ? 15 : 25,
                          fontJudul: alat.judul,
                          judulWarna: alat.teksPutihSedang,
                          isiTengah: true,
                          pakaiHover: true,
                          pakaiKlik: true,
                          padaHoverAnimasi: padaHoverAnimasi1,
                          padaHoverPemisahGarisLuarWarna: alat.kotakPutih,
                          padaHoverGarisLuarGradient: alat.terpilih,
                          padaKlikAnimasi: padaKlikAnimasi1,
                          susunGambarTeksBaris: Axis.vertical,
                          padaKlik: () {
                            kBelajar.aturMateriSekarang(kProgress, i + 1);
                            kLog.catatLogBelajar(modul: kBelajar.modulSekarang, materi: i + 1);
                            kontrolMenu.bukaMenu(2);
                          },
                          padaHoverBayanganGarisLuar: alat.boxShadowHover,
                          bayanganKotak: alat.boxShadow,
                        );
                      })
                    )
                  ),
                  SizedBox(height: 10),
                ],
              ),
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

    return Row(
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
                  tepiRadius: 30,
                  kotakGradient: alat.warnaHeader,
                  gambar: materi.gambar,
                  besarGambar: null,
                  warnaGambarColor: alat.kotakPutih,
                  tepiRadiusGambar: 10,
                  susunGambarTeksBaris: Axis.vertical,
                  bayanganKotak: alat.boxShadow,
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
                              bayanganJudul: alat.teksShadow,
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
    );
  }
}