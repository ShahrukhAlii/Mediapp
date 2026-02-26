import 'dart:async';
import 'dart:math';
import 'package:ecoms/welcomeScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _logoController;
  late AnimationController _arcController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    /// Logo → slow clockwise
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    /// Arc → fast anti-clockwise
    _arcController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    /// Pulse effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);

    /// Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _arcController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F5BEA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ================= PREMIUM LOADER =================
            AnimatedBuilder(
              animation: Listenable.merge(
                  [_logoController, _arcController, _pulseController]),
              builder: (_, child) {
                return Transform.scale(
                  scale: _pulseController.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [

                      /// Anti-clockwise rotating arc
                      Transform.rotate(
                        angle: -_arcController.value * 2 * pi,
                        child: CustomPaint(
                          size: const Size(180, 180),
                          painter: ArcPainter(
                            color: Colors.white,
                          ),
                        ),
                      ),

                      /// Clockwise rotating logo
                      Transform.rotate(
                        angle: _logoController.value * 2 * pi,
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Image.asset(
                            '../images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            /// App Name
            const Text(
              "Skin\nFlirt",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w100,
                color: Colors.white,
                height: 1.1,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Dermatology Centre",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= ARC PAINTER =================

class ArcPainter extends CustomPainter {
  final Color color;

  ArcPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 6.0;
    final radius = size.width / 2 - strokeWidth;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    /// Gradient arc
    final gradient = SweepGradient(
      colors: [
        color.withOpacity(0.1),
        color.withOpacity(0.4),
        color,
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    /// 270° arc
    canvas.drawArc(rect, 0, 1.7 * pi, false, paint);

    /// Glowing dot
    final dotAngle = 1.7 * pi;
    final dx = size.width / 2 + radius * cos(dotAngle);
    final dy = size.height / 2 + radius * sin(dotAngle);

    final glowPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final dotPaint = Paint()..color = color;

    canvas.drawCircle(Offset(dx, dy), 10, glowPaint);
    canvas.drawCircle(Offset(dx, dy), 6, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
