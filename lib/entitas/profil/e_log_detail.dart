class ELogDetail {
  final String id;
  final DateTime waktu;
  final String tipe; // belajar / kuis / tes
  final int? modul;
  final int? materi;      // rename dari "item"
  final int? idKuis;      // rename dari idSoal
  final bool? jawabanBenar;
  final int? skor;
  final String? aksi;

  ELogDetail({
    required this.id,
    required this.waktu,
    required this.tipe,
    this.modul,
    this.materi,
    this.idKuis,
    this.jawabanBenar,
    this.skor,
    this.aksi,
  });

  factory ELogDetail.fromJson(Map<String, dynamic> json) {
    return ELogDetail(
      id: json['id'] as String,
      waktu: DateTime.parse(json['waktu']),
      tipe: json['tipe'],
      modul: json['modul'],
      materi: json['materi'],
      idKuis: json['idKuis'],
      jawabanBenar: json['jawabanBenar'],
      skor: json['skor'],
      aksi: json['aksi'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'waktu': waktu.toIso8601String(),
        'tipe': tipe,
        'modul': modul,
        'materi': materi,
        'idKuis': idKuis,
        'jawabanBenar': jawabanBenar,
        'skor': skor,
        'aksi': aksi,
      };
}