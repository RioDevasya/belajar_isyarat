class EProfil {
  String? nama;
  String? sekolah;
  String? jabatan;
  bool bahasaInggris;
  List<int> progressBelajarIndo;
  List<int> nilaiTesIndo;
  int progressKuisIndo;
  List<int> progressBelajarInggris;
  List<int> nilaiTesInggris;
  int progressKuisInggris;

  EProfil({
    this.nama,
    this.sekolah,
    this.jabatan,
    required this.bahasaInggris,
    required this.progressBelajarIndo,
    required this.progressKuisIndo,
    required this.nilaiTesIndo,
    required this.progressBelajarInggris,
    required this.progressKuisInggris,
    required this.nilaiTesInggris,
  });
  
  factory EProfil.fromJson(Map<String, dynamic> json) {
    return EProfil(
      nama: json['nama'],
      sekolah: json['sekolah'],
      jabatan: json['jabatan'],
      bahasaInggris: json['bahasa_inggris'],
      progressBelajarIndo: List<int>.from(json['progress_belajar_indo']),
      nilaiTesIndo: List<int>.from(json['nilai_tes_modul_indo']),
      progressKuisIndo: json['progress_kuis_indo'],
      progressBelajarInggris: List<int>.from(json['progress_belajar_inggris']),
      nilaiTesInggris: List<int>.from(json['nilai_tes_modul_inggris']),
      progressKuisInggris: json['progress_kuis_inggris'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'sekolah': sekolah,
      'jabatan': jabatan,
      'bahasaInggris': bahasaInggris,
      'progress_belajar_indo': progressBelajarIndo,
      'nilai_tes_modul_indo': nilaiTesIndo,
      'progress_kuis_indo': progressKuisIndo,
      'progress_belajar_inggris': progressBelajarInggris,
      'nilai_tes_modul_inggris': nilaiTesInggris,
      'progress_kuis_inggris': progressKuisInggris,
    };
  }
}