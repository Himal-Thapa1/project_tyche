// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:project_tyche/spinwheelscreen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // Future that resolves when initialization is complete or encounters an error
//   Future<void> _initializeAssetsAudioPlayer() async {
//     try {
//       // Perform any necessary initialization for assets_audio_player here
//       // For example, you may call AssetsAudioPlayer.setupNotifications() if needed
//     } catch (e) {
//       // Handle initialization error
//       if (kDebugMode) {
//         print('Error initializing assets_audio_player: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: FutureBuilder(
//         future: _initializeAssetsAudioPlayer(),
//         builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Show loading indicator while initializing
//             return const Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             // Show error message if initialization fails
//             return Scaffold(
//               body: Center(
//                 child: Text('Initialization Error: ${snapshot.error}'),
//               ),
//             );
//           } else {
//             // Initialization successful, return your main widget
//             return const SpinWheel();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_tyche/spinwheelscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SpinWheel()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/splash_animation.json',
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
