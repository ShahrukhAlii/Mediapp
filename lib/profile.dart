import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'EditProfileScreen.dart';
import 'HelpNProfile.dart';
import 'PrivacyPolicyScreen.dart';
import 'SettingsScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color bgColor = Color(0xFFF5F6FA);
  static const Color primary = Color(0xFF5A6CF3);
  static const Color iconBg = Color(0xFFE8ECFF);

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(iconPath: "../images/p1.svg", title: "Profile", showArrow: true, onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProfileScreen(), // Replace with your target screen
          ),
        );
      }),
      MenuItem(iconPath: "../images/p2.svg", title: "Favorite", showArrow: true, onTap: () {}),
      MenuItem(iconPath: "../images/py.svg", title: "Payment Method", showArrow: true, onTap: () {}),
      MenuItem(iconPath: "../images/p3.svg", title: "Privacy Policy", showArrow: true, onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PrivacyPolicyScreen(), // Replace with your target screen
          ),
        );
      }),
      MenuItem(iconPath: "../images/p4.svg", title: "Settings", showArrow: true, onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(), // Replace with your target screen
          ),
        );
      }),
      MenuItem(iconPath: "../images/p5.svg", title: "Help", showArrow: true, onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HelpCenterApp(), // Replace with your target screen
          ),
        );

      }),
      MenuItem(iconPath: "../images/logout.svg", title: "Logout", showArrow: false, onTap: () {}),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [

            /// HEADER
            /// HEADER
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [

                  /// LEFT BACK ARROW
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      "../images/bk.svg",
                      height: 18,
                      width: 18,
                    ),
                  ),

                  /// CENTER TITLE
                  Expanded(
                    child: Center(
                      child: const Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: ProfileScreen.primary,
                        ),
                      ),
                    ),
                  ),

                  /// RIGHT SPACER (empty, to balance left arrow)
                  const SizedBox(width: 18), // same as arrow width to keep title centered
                ],
              ),
            ),


            const SizedBox(height: 20),

            /// AVATAR
            Stack(
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(radius: 64, backgroundImage: AssetImage("../images/doc.jpeg")),
                Positioned(
                  bottom: -3,
                  right: -3,
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "../images/edit.svg",
                        height: 16,
                        width: 16,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            const Text("John Doe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),

            const SizedBox(height: 36),

            /// MENU
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return ProfileRow(
                    iconPath: item.iconPath,
                    title: item.title,
                    showArrow: item.showArrow,
                    onTap: item.onTap,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MENU ITEM MODEL
class MenuItem {
  final String iconPath;
  final String title;
  final bool showArrow;
  final VoidCallback onTap;

  MenuItem({required this.iconPath, required this.title, required this.showArrow, required this.onTap});
}

/// CLICKABLE ROW WITH ROUNDED RIPPLE
class ProfileRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool showArrow;
  final VoidCallback onTap;

  const ProfileRow({super.key, required this.iconPath, required this.title, required this.showArrow, required this.onTap});

  static const Color primary = Color(0xFF5A6CF3);
  static const Color iconBg = Color(0xFFE8ECFF);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  /// LEFT ICON
                  Container(
                    height: 44,
                    width: 44,
                    decoration: const BoxDecoration(color: iconBg, shape: BoxShape.circle),
                    child: Center(
                      child: SvgPicture.asset(
                        iconPath,
                        height: 20,
                        width: 20,
                        colorFilter: const ColorFilter.mode(primary, BlendMode.srcIn),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// TEXT + ARROW
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        if (showArrow) SvgPicture.asset("../images/arrow.svg", height: 14, width: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
