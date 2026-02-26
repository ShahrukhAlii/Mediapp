import 'package:ecoms/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'calender.dart';
import 'doctors_list_screen.dart';
import 'message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}




class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  bool isFavorite;
  final String avatar;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    this.isFavorite = false,
    this.avatar = "",
  });
}

// ================= DOTTED LINE PAINTER =================
class HorizontalDottedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  HorizontalDottedLinePainter({
    this.color = const Color(0xff2260FF),
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.4)
      ..strokeWidth = 1;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomIndex = 0;
  int selectedDateIndex = 2;
  String searchQuery = "";


  // Add your screens here
  final List<Widget> _screens = [
    const HomeScreen(), // Extract your existing Home screen body into a widget
    const ProfileScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];


  final List<Doctor> doctors = [
    Doctor(
        name: "Dr. Olivia Turner, M.D.",
        specialty: "Dermato-Endocrinology",
        rating: 5.0,
        reviews: 60),
    Doctor(
        name: "Dr. Alexander Bennett, Ph.D.",
        specialty: "Dermato-Genetics",
        rating: 4.5,
        reviews: 40),
    Doctor(
        name: "Dr. Sophia Martinez, Ph.D.",
        specialty: "Cosmetic Bioengineering",
        rating: 5.0,
        reviews: 150),
  ];


  String userName = "";
  String userAvatar = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }


  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String name = user.displayName ??
          (user.email != null ? user.email!.split('@')[0] : "User");

      setState(() {
        userName = name;
        userAvatar = user.photoURL ?? "";
      });
    } else {
      setState(() {
        userName = "Guest";
        userAvatar = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define your screens
    final List<Widget> _screens = [
      // Keep your existing Home screen body as a separate widget
      SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildTopRow(),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffE6F0FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  _buildDateSelector(isInBlue: true),
                  const SizedBox(height: 15),
                  _buildAppointmentCard(isInBlue: true),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(child: _buildDoctorList()),
          ],
        ),
      ),

      // Add your other screens here
      const MediConnectApp(),
      const ProfileScreen(),
      const AppointmentScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      // Show the selected screen
      body: IndexedStack(
        index: selectedBottomIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }


  // ================= HEADER =================
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage:
            userAvatar.isNotEmpty ? NetworkImage(userAvatar) : null,
            child: userAvatar.isEmpty ? const Icon(Icons.person) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hi, Welcome Back",
                  style: TextStyle(color: Color(0xff4894FE)),
                ),
                Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _roundIcon(Icons.notifications_none, () {
            _showMessage("Notifications Clicked");
          }),
          const SizedBox(width: 10),
          _roundIcon(Icons.settings, () {
            _showMessage("Settings Clicked");
          }),
        ],
      ),
    );
  }

  Widget _roundIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 22),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // ================= TOP ROW =================
  Widget _buildTopRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>  DoctorsListScreen(),
                ),
              );
            },
            child: _iconWithLabel(
              svgPath: "../images/doc.svg",
              label: "Doctor",
              bgColor: const Color(0xffE9F0FF),
              iconColor: const Color(0xff2260FF),
            ),
          ),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>  DoctorsListScreen(),
      ),
    );
  },child:  _iconWithLabel(
  svgPath: "../images/heart.svg", // Correct path to your SVG
  label: "Favorite",
  bgColor: const Color(0xffE9F0FF),
  iconColor: Colors.red,
),

),
          const SizedBox(width: 16),

          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Search doctor",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xff2260FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.filter_list, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= ICON WITH LABEL =================
  Widget _iconWithLabel({
    String? svgPath,
    IconData? icon,
    required String label,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: bgColor,
          child: svgPath != null
              ? SvgPicture.asset(
            svgPath,
            width: 24,
            height: 24,
            color: iconColor,
          )
              : Icon(icon, size: 24, color: iconColor),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // ================= DATE SELECTOR =================
  Widget _buildDateSelector({bool isInBlue = false}) {
    final List<String> dates = ["9\nMON", "10\nTUE", "11\nWED", "12\nTHU", "13\nFRI"];
    return SizedBox(
      height: 125,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedDateIndex;
          return GestureDetector(
            onTap: () => setState(() => selectedDateIndex = index),
            child: Container(
              width: 65,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: isInBlue
                    ? (isSelected ? Colors.white : Color(0xff2260FF))
                    : (isSelected ? const Color(0xff2260FF) : Colors.white),
                borderRadius: BorderRadius.circular(28),
              ),
              alignment: Alignment.center,
              child: Text(
                dates[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isInBlue
                      ? (isSelected ? const Color(0xff2260FF) : Colors.white)
                      : (isSelected ? Colors.white : Colors.black),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= APPOINTMENT CARD =================
  Widget _buildAppointmentCard({bool isInBlue = false}) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: isInBlue ? Colors.white : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Date text slightly right
          Container(
            alignment: Alignment(0.7, 0),
            child: Text(
              "11 Wednesday- today",
              style: TextStyle(
                color: const Color(0xff2260FF),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 5),

          // Row with times and timeline
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // vertically center
                children: const [
                  Text(
                    "9 AM",
                    style: TextStyle(
                        color: Color(0xff2260FF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "10 AM",
                    style: TextStyle(
                        color: Color(0xff2260FF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "11 AM",
                    style: TextStyle(
                        color: Color(0xff2260FF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 14), // adjusted spacing for balance
                  Text(
                    "12 AM",
                    style: TextStyle(
                        color: Color(0xff2260FF),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),


              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  children: [
                    // Top dotted line
                    Row(
                      children: [
                        const SizedBox(width: 0),
                        Expanded(
                          child: Container(
                            height: 1,
                            child: CustomPaint(
                                painter: HorizontalDottedLinePainter(
                                    color: Color(0xff2260FF))),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xffE6F0FF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Doctor Name
                                const Expanded(
                                  child: Text(
                                    "Dr. Olivia Turner, M.D.",
                                    style: TextStyle(
                                      color: Color(0xff2260FF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),

                                // Check Icon with circular background
                                Container(
                                  height: 22,
                                  width: 22,
                                  decoration: const BoxDecoration(
                                    color: Colors.white, // Blue circle background
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Color(0xff2260FF), // White check mark
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // Cancel Icon with circular background
                                Container(
                                  height: 22,
                                  width: 22,
                                  decoration: const BoxDecoration(
                                    color: Colors.white, // Red circle background
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color:Color(0xff2260FF), // White X mark
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),
                            const Text(
                              "Treatment and prevention of skin and photodermatitis.",
                              style: TextStyle(
                                  color: Color(0xff2260FF),
                                  fontSize: 13,
                                  height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        const SizedBox(width: 0),
                        Expanded(
                          child: Container(
                            height: 1,
                            child: CustomPaint(
                                painter: HorizontalDottedLinePainter(
                                    color: Color(0xff2260FF))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
// ================= DOCTOR LIST =================
  Widget _buildDoctorList() {
    final filteredDoctors =
    doctors.where((doc) => doc.name.toLowerCase().contains(searchQuery)).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: filteredDoctors.length,
      itemBuilder: (context, index) {
        final doc = filteredDoctors[index];

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF2FF), // light blue card background
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // vertical center
            children: [

              // ===== Profile Image =====
              CircleAvatar(
                radius: 40, // larger outer circle
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 36, // larger image
                  backgroundImage: const AssetImage('../images/doc.jpeg'),
                  backgroundColor: Colors.grey.shade200,
                ),
              ),

              const SizedBox(width: 16),

              // ===== Right Content =====
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // vertical center
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ===== White Heading Box =====
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white, // only this box white
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFF2A4B9B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            doc.specialty,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ===== Bottom Row: Rating, Reviews, Help, Favorite =====
                    Row(
                      children: [

                        // Rating Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, size: 14, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(
                                "${doc.rating}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Reviews Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.chat_bubble_outline,
                                  size: 14, color: Colors.blue),
                              const SizedBox(width: 4),
                              Text(
                                "${doc.reviews}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Help Icon
                        Container(
                          height: 34,
                          width: 34,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.help_outline,
                            size: 18,
                            color: Colors.blue,
                          ),
                        ),

                        // Favorite Icon
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              doc.isFavorite = !doc.isFavorite;
                            });
                          },
                          child: Container(
                            height: 34,
                            width: 34,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              doc.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 18,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// ================= BOTTOM NAVIGATION =================
  Widget _buildBottomNavigation() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xff2260FF),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItemSvg('../images/home.svg', 0),
          _navItemSvg('../images/msg.svg', 1),
          _navItemSvg('../images/profile.svg', 2),
          _navItemSvg('../images/caln.svg', 3),
        ],
      ),
    );
  }

  Widget _navItemSvg(String svgPath, int index) {
    final isSelected = selectedBottomIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedBottomIndex = index),
      child: Container(
        padding: const EdgeInsets.all(12), // adds tappable area
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent, // subtle highlight
          borderRadius: BorderRadius.circular(20),
        ),
        child: SvgPicture.asset(
          svgPath,
          height: 28,
          width: 28,
          color: isSelected ? Colors.white : Colors.white70,
        ),
      ),
    );
  }

}

