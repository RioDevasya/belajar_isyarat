import 'package:flutter/material.dart';

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
  });
  
  Widget _bangunGarisLuar(Widget child) {
    return Container(
      width: besar + besarGarisLuar,
      height: besar + besarGarisLuar,
      decoration: BoxDecoration(
        color: warnaLingkaran,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan warna dasar

    Icon? simbol;

    // Prioritas warna
    switch (benarSalahNetral) {
      case 1: 
        simbol = Icon(
          Icons.check,
          color: warnaSimbolAngka,
          size: besar * 0.55,
        );
        break;

      case 2: 
        simbol = Icon(
          Icons.close,
          color: warnaSimbolAngka,
          size: besar * 0.55,
        );
        break;
      
      case 3: 
        simbol = Icon(
          Icons.minimize,
          color: warnaSimbolAngka,
          size: besar * 0.55,
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
          fontSize: besar * 0.45,
          fontWeight: FontWeight.w300,
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
      child: simbol ?? isi ?? Icon(
        Icons.question_mark,
        color: warnaSimbolAngka,
        size: besar * 0.55,
      ),
    );

    if (besarGarisLuar > 0.0) {
      return _bangunGarisLuar(widgetUtama);
    } else {
      return widgetUtama;
    }
  }
}