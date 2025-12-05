import 'package:flutter/material.dart';

class ReorderDemo extends StatefulWidget {
  const ReorderDemo({super.key});

  @override
  State<ReorderDemo> createState() => _ReorderDemoState();
}

class _ReorderDemoState extends State<ReorderDemo> {
  List<String?> atas = ["A1", "A2", "A3", null];
  List<String> bawah = ["B1", "B2", "B3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reorder Demo FIXED")),
      body: Column(
        children: [
          // LIST ATAS
          Expanded(
            child: buildList(
              label: "Atas",
              items: atas,
              listName: "atas",
              onAcceptFromOther: (fromList, fromIndex, value) {
                setState(() {
                  // isi slot null terlebih dahulu
                  int slot = atas.indexWhere((e) => e == null);
                  if (slot != -1) {
                    atas[slot] = value;
                  } else {
                    atas.add(value);
                  }

                  if (fromList == "bawah") {
                    bawah.removeAt(fromIndex);
                  }
                });
              },
            ),
          ),

          const Divider(height: 40),

          // LIST BAWAH
          Expanded(
            child: buildList(
              label: "Bawah",
              items: bawah,
              listName: "bawah",
              onAcceptFromOther: (fromList, fromIndex, value) {
                setState(() {
                  bawah.add(value);
                  if (fromList == "atas") atas[fromIndex] = null;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // WIDGET LIST REORDERABLE (Dua Fungsi: reorder & pindah list)
  // =========================================================
  Widget buildList({
    required String label,
    required List items,
    required String listName,
    required Function(String fromList, int fromIndex, String value)
        onAcceptFromOther,
  }) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(items.length, (i) {
            final item = items[i];

            // ===========================
            // SLOT KOSONG
            // ===========================
            if (item == null) {
              return DragTarget<Map<String, dynamic>>(
                onWillAccept: (data) => true,
                onAccept: (data) {
                  onAcceptFromOther(data["from"], data["index"], data["value"]);
                },
                builder: (context, c, r) => placeholderBox(),
              );
            }

            // ===========================
            // ITEM BIASA
            // ===========================
            return Draggable<Map<String, dynamic>>(
              data: {"from": listName, "index": i, "value": item},
              feedback: Material(
                color: Colors.transparent,
                child: buildBox(item, isDragging: true),
              ),
              childWhenDragging: buildBox(item, ghost: true),

              /// DROP TARGET DI DALAM DRAGGABLE (untuk reorder)
              child: DragTarget<Map<String, dynamic>>(
                onWillAccept: (_) => true,
                onAccept: (data) {
                  setState(() {
                    final fromList = data["from"];
                    final fromIndex = data["index"];
                    final value = data["value"];

                    if (fromList == listName) {
                      // ======================
                      // REORDER INTERNAL
                      // ======================
                      if (fromIndex != i) {
                        final removed = items.removeAt(fromIndex);
                        items.insert(i > fromIndex ? i - 1 : i, removed);
                      }
                    } else {
                      // ======================
                      // PINDAH DARI LIST LAIN
                      // ======================
                      onAcceptFromOther(fromList, fromIndex, value);
                    }
                  });
                },
                builder: (context, c, r) => buildBox(item),
              ),
            );
          }),
        ),
      ],
    );
  }

  // Kotak item
  Widget buildBox(String text, {bool ghost = false, bool isDragging = false}) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ghost
            ? Colors.grey.shade400
            : (isDragging ? Colors.blue.shade300 : Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  // Placeholder kosong
  Widget placeholderBox() {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.grey.shade300,
      ),
      child: const Text("Kosong"),
    );
  }
}
