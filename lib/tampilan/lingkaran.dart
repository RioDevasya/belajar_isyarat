import 'package:belajar_isyarat/alat/alat_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lingkaran extends StatelessWidget {
  final double besar;
  final Color? warnaLingkaran;
  final LinearGradient? gradienLingkaran;
  final Color? warnaSimbolAngka;

  final double besarGarisLuar;
  final Color? warnaGarisLuar;
  final LinearGradient? gradienGarisLuar;

  final int? benarSalahNetral;       // null = mode angka saja (jika ada angka)
  final int? angka;        // angka ditampilkan jika ada
  final double? padding;

  const Lingkaran({
    super.key,
    required this.besar,
    this.warnaLingkaran,
    this.gradienLingkaran,
    this.warnaSimbolAngka,

    this.besarGarisLuar = 0.0,
    this.warnaGarisLuar,
    this.gradienGarisLuar,

    this.benarSalahNetral,
    this.angka,
    this.padding
  });
  
  Widget _bangunGarisLuar(Widget child, List<BoxShadow>? shadow) {
    return Container(
      width: besar + besarGarisLuar,
      height: besar + besarGarisLuar,
      decoration: BoxDecoration(
        color: warnaGarisLuar,
        shape: BoxShape.circle,
        boxShadow: shadow
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan warna dasar

    Widget? simbol;
    final alat = context.read<AlatApp>();

    // Prioritas warna
    switch (benarSalahNetral) {
      case 1: 
        simbol = Icon(
          Icons.check,
          color: warnaSimbolAngka,
          size: besar * 0.85 - (padding ?? 0),
        );
        break;

      case 2: 
        simbol = Icon(
          Icons.close,
          color: warnaSimbolAngka,
          size: besar * 0.85 - (padding ?? 0),
        );
        break;
      
      case 3: 
        simbol = Icon(
          Icons.minimize,
          color: warnaSimbolAngka,
          size: besar * 0.85 - (padding ?? 0),
        );
        break;

      case 4: 
        simbol = Icon(
          Icons.priority_high,
          color: warnaSimbolAngka,
          size: besar * 0.85 - (padding ?? 0),
        );
        break;
    }

    Widget? isi;

    // Tentukan isi lingkaran
    if (angka != null) {
      // MODE ANGKA
      isi = Text(
        angka.toString(),
        style: TextStyle(
          color: warnaSimbolAngka,
          fontSize: besar * 0.55 - (padding ?? 0),
          fontWeight: FontWeight.bold,
          fontFamily: alat.teks,
        ),
      );
    }
    
    final widgetUtama = Container(
      width: besar,
      height: besar,
      decoration: BoxDecoration(
        color: warnaLingkaran,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      padding: padding != null ? EdgeInsets.all(padding!) : null,
      child: simbol ?? isi ?? Icon(
        Icons.question_mark,
        color: warnaSimbolAngka,
        size: besar * 0.55,
      ),
    );

    if (besarGarisLuar > 0.0) {
      return _bangunGarisLuar(widgetUtama, null);
    } else {
      return widgetUtama;
    }
  }
}