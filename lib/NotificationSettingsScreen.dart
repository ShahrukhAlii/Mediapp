import 'package:flutter/material.dart';


class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  // Toggle states
  final Map<String, bool> toggles = {
    "General Notification": true,
    "Sound": true,
    "Sound Call": false,
    "Vibrate": true,
    "Special Offers": false,
    "Payments": true,
    "Promo and Discount": false,
    "Cashback": true,
  };

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
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Color(0xFF2260FF), // back arrow color
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: const Text(
                        "Notification Settings",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2260FF),
                        ),
                      ),
                    ),
                  ),
                  // Balancing SizedBox to ensure title is perfectly centered
                  const SizedBox(width: 24),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== TOGGLE LIST =====
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: toggles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  String key = toggles.keys.elementAt(index);
                  return buildToggleRow(key, toggles[key]!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToggleRow(String title, bool value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row text
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),

          // Toggle Switch
          Switch(
            value: value,
            onChanged: (bool newValue) {
              setState(() {
                toggles[title] = newValue;
              });
            },
            activeColor: const Color(0xFFFFFFFF), // knob color
            activeTrackColor: const Color(0xFFCAD6FF), // track when ON
            inactiveThumbColor: const Color(0xFFFFFFFF), // knob when OFF
            inactiveTrackColor: const Color(0xFF2260FF), // track when OFF
            trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}
