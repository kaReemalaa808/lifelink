import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'login_screen.dart'; // استدعي شاشة اللوجين

class ScaleDemo extends StatefulWidget {
  const ScaleDemo({super.key});

  @override
  State<ScaleDemo> createState() => _ScaleDemoState();
}

class _ScaleDemoState extends State<ScaleDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // مسؤول عن تشغيل الأنيميشن
  late Animation<double> _animation; // قيمة التكبير

  //  final AudioPlayer _player = AudioPlayer(); // مشغل الصوت

  @override
  void initState() {
    super.initState();

    // إنشاء AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // مدة الأنيميشن
    );

    // تحديد حركة التكبير من 0 → 1 (يظهر تدريجياً)
    _animation =
        Tween<double>(
          begin: 0.0, // يبدأ من غير حجم (مختفي)
          end: 1.0, // يصل للحجم الطبيعي
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.elasticOut, // bounce effect
          ),
        );

    // تشغيل الصوت + الأنيميشن بعد تحميل الشاشة
    _startAnimation();

    // بعد انتهاء الأنيميشن → الانتقال للوجين
    Timer(const Duration(milliseconds: 1600), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  // تشغيل الصوت والأنيميشن
  Future<void> _startAnimation() async {
    // تشغيل الصوت
    //  await _player.play(AssetSource('sounds/pop.mp3'));

    // تشغيل الأنيميشن
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    //_player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        // ScaleTransition مسؤول عن تكبير اللوجو
        child: ScaleTransition(
          scale: _animation,

          child: Image.asset(
            "images/logo.png",
            // حط هنا اللوجو بتاعك
            width: 300,
          ),
        ),
      ),
    );
  }
}
