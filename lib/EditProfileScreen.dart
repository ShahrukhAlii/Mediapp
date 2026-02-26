import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

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
                        "Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5A6CF3),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Settings tapped / navigate to edit profile
                    },
                    child: Container(
                      height: 36, // adjust size to match screenshot
                      width: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5A6CF3), // background color from screenshot
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "../images/setting.svg",
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== AVATAR WITH EDIT ICON =====
            Stack(
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundImage: AssetImage("../images/doc.jpeg"),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Edit avatar tapped
                    },
                    child: Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5A6CF3),
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
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ===== FORM FIELDS =====
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name
                    buildField("Full Name", fullNameController, "Enter Full Name"),
                    const SizedBox(height: 16),

                    // Phone Number
                    buildField("Phone Number", phoneController, "Enter Phone Number", keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),

                    // Email
                    buildField("Email", emailController, "Enter Email", keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),

                    // Date of Birth
                    buildDateOfBirthField(dobController, "DD / MM / YYYY"),
                    const SizedBox(height: 40),

                    // Update Profile Button
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5A6CF3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          // Update profile tapped
                        },
                        child: const Text(
                          "Update Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Generic input field with label and hint
  Widget buildField(String label, TextEditingController controller, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8ECFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.blue.shade300),
            ),
          ),
        ),
      ],
    );
  }

  /// Date of Birth field with label, hint, and calendar picker
  Widget buildDateOfBirthField(TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date Of Birth",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              final formattedDate = "${pickedDate.day.toString().padLeft(2, '0')} / "
                  "${pickedDate.month.toString().padLeft(2, '0')} / "
                  "${pickedDate.year}";
              setState(() {
                controller.text = formattedDate;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE8ECFF),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            alignment: Alignment.centerLeft,
            child: Text(
              controller.text.isEmpty ? hint : controller.text,
              style: TextStyle(
                fontSize: 16,
                color: controller.text.isEmpty ? Colors.blue.shade300 : Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
