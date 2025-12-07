import 'package:belajar_isyarat/entitas/profil/e_log_detail.dart';
import 'package:flutter/material.dart';
import '../../kontrol/kontrol_log.dart';
import 'package:fl_chart/fl_chart.dart';

class MenuProgressBody extends StatefulWidget {
  const MenuProgressBody({super.key});

  @override
  State<MenuProgressBody> createState() => _MenuProgressBodyState();
}

class _MenuProgressBodyState extends State<MenuProgressBody> {
  final ScrollController _scrollController = ScrollController();

  int totalMateri = 0;
  int totalTes = 0;
  int totalKuis = 0;
  int totalSkor = 0;

  List<int> nilaiTes = [];
  List<ChartPoint> nilaiKuisLine = [];
  List<ELogDetail> semuaLog = [];

  @override
  void initState() {
    super.initState();
    muatSemua();
  }

  Future<void> muatSemua() async {
    final log = KontrolLog();
    final list = await log.ambilListLog();

    totalMateri = list.where((e) => e.tipe == "belajar").length;
    totalTes     = list.where((e) => e.tipe == "tes").length;
    totalKuis    = list.where((e) => e.tipe == "kuis").length;
    totalSkor    = list.fold(0, (s, e) => s + (e.skor ?? 0));

    nilaiTes = list.where((e) => e.tipe == "tes").map((e) => e.skor ?? 0).toList();
    nilaiKuisLine = list.where((e) => e.tipe == "kuis").toList().asMap().entries
        .map((ent) => ChartPoint("K${ent.key + 1}", ent.value.skor ?? 0)).toList();

    semuaLog = list.reversed.toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ============================================================
            //                     BAGIAN STATISTIK
            // ============================================================
            Row(
              children: [
                Expanded(child: _statCard(Icons.book, totalMateri, "Materi Dipelajari")),
                const SizedBox(width: 10),
                Expanded(child: _statCard(Icons.check_circle, totalTes, "Tes Selesai")),
                const SizedBox(width: 10),
                Expanded(child: _statCard(Icons.star, totalSkor, "Total Skor")),
              ],
            ),

            const SizedBox(height: 20),

            // ============================================================
            //      BAGIAN CHART: TES (BAR) DAN KUIS (LINE)
            // ============================================================
            Row(
              children: [
                Expanded(child: _chartBarTes()),
                const SizedBox(width: 10),
                Expanded(child: _chartLineKuis()),
              ],
            ),

            const SizedBox(height: 20),

            // ============================================================
            //                         LIST LOG
            // ============================================================
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 3, child: _logListFixed()),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: const [
                        _moduleCard("Modul 1", 0.5),
                        SizedBox(height: 8),
                        _moduleCard("Modul 2", 0.2),
                        SizedBox(height: 8),
                        _moduleCard("Modul 3", 0.1),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //                       STAT CARD
  // ============================================================
  Widget _statCard(IconData icon, int value, String label) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          const SizedBox(height: 6),
          Text(value.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // ============================================================
  //                         LOG LIST
  // ============================================================
  Widget _logListFixed() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _chartDeco(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Log Aktivitas",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Expanded(          // << membuat tinggi mengikuti modul card!
            child: semuaLog.isEmpty
                ? const Center(child: Text("Belum ada aktivitas"))
                : ListView.separated(
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: semuaLog.length,
                    itemBuilder: (_, i) {
                      final e = semuaLog[i];

                      IconData icon;
                      Color color;

                      switch (e.tipe) {
                        case "kuis":
                          icon = e.jawabanBenar == true ? Icons.check : Icons.close;
                          color = e.jawabanBenar == true ? Colors.green : Colors.red;
                          break;
                        case "tes":
                          icon = Icons.assignment;
                          color = Colors.orange;
                          break;
                        default:
                          icon = Icons.book;
                          color = Colors.blue;
                      }

                      return ListTile(
                        dense: true,
                        leading: Icon(icon, color: color),
                        title: Text("${e.tipe.toUpperCase()} • ${e.aksi ?? ''}"),
                        subtitle: Text(e.waktu.toString(),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: e.skor != null
                            ? Text("${e.skor} pts",
                                style: TextStyle(
                                    color: color, fontWeight: FontWeight.bold))
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //                    CHART UTILITIES
  // ============================================================
  Widget _chartBarTes() {
    if (nilaiTes.isEmpty) return _chartEmpty("Belum ada data Tes");

    return Container(
      height: 260,
      padding: const EdgeInsets.all(12),
      decoration: _chartDeco(),
      child: BarChart(
        BarChartData(
          maxY: 100,
          barGroups: List.generate(nilaiTes.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [BarChartRodData(toY: nilaiTes[i].toDouble(), width: 16)],
            );
          }),
        ),
      ),
    );
  }

  Widget _chartLineKuis() {
    if (nilaiKuisLine.isEmpty) return _chartEmpty("Belum ada data Kuis");

    return Container(
      height: 260,
      padding: const EdgeInsets.all(12),
      decoration: _chartDeco(),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                nilaiKuisLine.length,
                (i) =>
                    FlSpot(i.toDouble(), nilaiKuisLine[i].value.toDouble()),
              ),
              isCurved: true,
              barWidth: 3,
              dotData: FlDotData(show: true),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _chartDeco() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      );

  Widget _chartEmpty(String msg) => Container(
        height: 260,
        decoration: _chartDeco(),
        child: Center(child: Text(msg)),
      );
}

// ============================================================
//                 MODEL UNTUK LINE CHART
// ============================================================
class ChartPoint {
  final String label;
  final int value;
  ChartPoint(this.label, this.value);
}


// ============================================================
//                 CARD PROGRESS MODUL
// ============================================================
class _moduleCard extends StatelessWidget {
  final String title;
  final double progress;

  const _moduleCard(this.title, this.progress);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress, minHeight: 10),
          const SizedBox(height: 6),
          Text("${(progress * 100).toStringAsFixed(0)}%"),
        ],
      ),
    );
  }
}