import 'package:flutter/material.dart';

class SlideBoxesWithAnimatedSwitcher extends StatefulWidget {
  const SlideBoxesWithAnimatedSwitcher({super.key});

  @override
  State<SlideBoxesWithAnimatedSwitcher> createState() =>
      _SlideBoxesWithAnimatedSwitcherState();
}

class _SlideBoxesWithAnimatedSwitcherState
    extends State<SlideBoxesWithAnimatedSwitcher> {
  int index = 0;
  bool isNext = true;

  final pages = const [
    Center(child: Text("BOX 1", style: TextStyle(fontSize: 40))),
    Center(child: Text("BOX 2", style: TextStyle(fontSize: 40))),
    Center(child: Text("BOX 3", style: TextStyle(fontSize: 40))),
  ];

  void next() {
    setState(() {
      isNext = true;
      index = (index + 1) % pages.length;
    });
  }

  void prev() {
    setState(() {
      isNext = false;
      index = (index - 1 + pages.length) % pages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smooth Slide (AnimatedSwitcher)")),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 420),
        switchInCurve: Curves.easeOut,      // masuk → lambat di akhir
        switchOutCurve: Curves.easeInOut,   // keluar → smooth awal-akhir
        transitionBuilder: (child, anim) {
          // offset 1.1 → lewat sedikit (offset 0.1)
          final beginOffset = isNext
              ? const Offset(1.1, 0) // masuk dari kanan
              : const Offset(-1.1, 0); // masuk dari kiri

          final offsetAnim = Tween<Offset>(
            begin: beginOffset,
            end: Offset.zero,
          ).animate(anim);

          return SlideTransition(
            position: offsetAnim,
            child: child,
          );
        },
        child: Container(
          key: ValueKey(index),   // wajib → memicu animasi switch
          child: pages[index],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: prev, child: const Text("PREV")),
            ElevatedButton(onPressed: next, child: const Text("NEXT")),
          ],
        ),
      ),
    );
  }
}