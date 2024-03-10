import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/subjects.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();
  final assetAudioPlayer =
      AssetsAudioPlayer(); // Create AssetAudioPlayer instance
  List<String> items = [
    "Eraser",
    "Pen",
    "nothing",
    "Chocolate",
    "Sharpener",
    "nothing"
  ];

  @override
  void dispose() {
    selected.close();
    assetAudioPlayer.dispose(); // Dispose AssetAudioPlayer on widget disposal
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Project Tyche",
              style: GoogleFonts.borel(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 300,
              child: FortuneWheel(
                selected: selected.stream,
                animateFirst: false,
                items: List<FortuneItem>.generate(
                  items.length,
                  (i) => FortuneItem(child: Text(items[i])),
                ),
                onAnimationEnd: () async {
                  String winItem = items[selected.value];
                  assetAudioPlayer.open(
                    Audio('assets/sounds/yay.mp3'),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(winItem == "nothing"
                            ? "Better Luck Next Time"
                            : "Congratulations!"),
                        content: Text(winItem == "nothing"
                            ? "You won nothing."
                            : "You won $winItem."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              assetAudioPlayer.stop();
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected.add(Fortune.randomInt(0, items.length));
                });
              },
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'SPIN',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
