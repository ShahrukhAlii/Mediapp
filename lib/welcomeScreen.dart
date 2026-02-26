import 'dart:math';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'SignupScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {

  late final AnimationController _logoController;
  late final AnimationController _arcController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    // Clockwise rotating logo
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Anti-clockwise rotating arc
    _arcController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Pulse effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
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
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// ================= Rotating Logo with Circle =================
              AnimatedBuilder(
                animation: Listenable.merge(
                    [_logoController, _arcController, _pulseController]),
                builder: (_, child) {
                  return Transform.scale(
                    scale: _pulseController.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Anti-clockwise rotating arc
                        Transform.rotate(
                          angle: -_arcController.value * 2 * pi,
                          child: CustomPaint(
                            size: const Size(160, 160),
                            painter: ArcPainter(
                              color: const Color(0xFF2F5BEA),
                            ),
                          ),
                        ),

                        // Clockwise rotating logo
                        Transform.rotate(
                          angle: _logoController.value * 2 * pi,
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              '../images/logo2.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              /// App Name
              const Text(
                "Skin\nFlirt",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF2F5BEA),
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 8),

              /// Subtitle
              const Text(
                "Dermatology Center",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2F5BEA),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 40),

              /// Description
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),

              const Spacer(),

              /// Log In Button
              SizedBox(
                width: 250,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F5BEA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Sign Up Button
              SizedBox(
                width: 250,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F5BEA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
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

    // Gradient arc
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

    // Draw 270° arc
    canvas.drawArc(rect, 0, 1.7 * pi, false, paint);

    // Glowing dot
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
