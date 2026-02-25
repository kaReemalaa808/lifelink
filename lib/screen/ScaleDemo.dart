import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lifelink/screen/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoMoveUp;

  late Animation<double> _textOpacity;
  late Animation<double> _textMoveUp;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    /// تكبير اللوجو + رجوعه طبيعي
    _logoScale = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.3,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.3,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 40,
      ),
    ]).animate(_logoController);

    /// إخفاء و إظهار تدريجي
    _logoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    /// تحريك اللوجو لفوق
    _logoMoveUp = Tween<double>(
      begin: 0,
      end: -15,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    /// ظهور النص تدريجي
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(_textController);

    /// النص قريب مش بعيد
    _textMoveUp = Tween<double>(begin: 10, end: 0).animate(_textController);

    startAnimation();
  }

  void startAnimation() async {
    await _logoController.forward();
    await _textController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // هنا نقرأ وضع الجهاز مباشرة
    final deviceBrightness = MediaQuery.of(context).platformBrightness;
    final isDark = deviceBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_logoController, _textController]),
          builder: (context, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// اللوجو
                Transform.translate(
                  offset: Offset(0, _logoMoveUp.value),
                  child: Opacity(
                    opacity: _logoOpacity.value,
                    child: Transform.scale(
                      scale: _logoScale.value,
                      child: Image.asset("images/logo.png", width: 250),
                    ),
                  ),
                ),

                const SizedBox(height: 0),

                /// اسم التطبيق
                Opacity(
                  opacity: _textOpacity.value,
                  child: Transform.translate(
                    offset: Offset(0, _textMoveUp.value),
                    child: Text(
                      "Life Link",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
