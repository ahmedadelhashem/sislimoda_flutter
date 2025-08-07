import 'package:flutter/material.dart';
import 'dart:html' as html; // مهم لـ Web
import 'package:flutter/foundation.dart' show kIsWeb;

class WebSoundTestScreen extends StatelessWidget {
  const WebSoundTestScreen({super.key});

  void playSound() {
    if (kIsWeb) {
      final audio = html.AudioElement()
        ..src = 'assets/sounds/spaceline.mp3'
        ..autoplay = false
        ..preload = 'auto';

      html.document.body?.append(audio); // ضروري لبعض المتصفحات

      audio.onCanPlay.first.then((_) {
        audio.play();
      }).catchError((e) {
        print("Error playing sound: $e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Web Sound')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            playSound();
          },
          child: Text("تشغيل الصوت"),
        ),
      ),
    );
  }
}
