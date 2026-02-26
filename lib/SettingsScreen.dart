import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'NotificationSettingsScreen.dart';
import 'PasswordManagerScreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== TOP BAR =====
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      "../images/bk.svg",
                      height: 18,
                      width: 18,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: const Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5A6CF3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== SETTINGS OPTIONS =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  buildOptionRow(
                    title: "Notification Settings",
                    leftIcon: "../images/noti.svg",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationSettingsScreen(), // Replace with your target screen
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildOptionRow(
                    title: "Password Manager",
                    leftIcon: "../images/Key.svg",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordManagerScreen(), // Replace with your target screen
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildOptionRow(
                    title: "Delete Account",
                    leftIcon: "../images/p1.svg",
                    onTap: () {
                      // TODO: Navigate in future
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Row design exactly like Profile screen (no shadow, simple)
  Widget buildOptionRow({
    required String title,
    required String leftIcon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: Colors.white, // simple white background
        child: Row(
          children: [
            // Left icon inside circle
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE8ECFF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  leftIcon,
                  height: 20,
                  width: 20,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            // Right arrow
            SvgPicture.asset(
              "../images/arrow.svg",
              height: 18,
              width: 18,
            ),
          ],
        ),
      ),
    );
  }
}
