import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'LoginScreen.dart';
import 'HomeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  /// EMAIL/PASSWORD SIGN-UP
  Future<void> _signUp() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save user info in Firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "phone": _phoneController.text.trim(),
        "dob": _dobController.text.trim(),
        "createdAt": Timestamp.now(),
      });

      // Send verification email
      await userCredential.user!.sendEmailVerification();

      // Navigate to LoginScreen
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Account created! Verification email sent. Please log in."),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Signup failed";
      if (e.code == 'email-already-in-use') message = "Email already registered.";
      else if (e.code == 'weak-password') message = "Password must be at least 6 characters.";
      else if (e.code == 'invalid-email') message = "Invalid email format.";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// GOOGLE SIGN-UP
  Future<void> _googleSignUp() async {
    try {
      setState(() => _isLoading = true);

      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      // Firestore entry only if new user
      if (userCredential.additionalUserInfo!.isNewUser) {
        await _firestore.collection("users").doc(userCredential.user!.uid).set({
          "name": userCredential.user!.displayName ?? "",
          "email": userCredential.user!.email ?? "",
          "phone": "",
          "dob": "",
          "createdAt": Timestamp.now(),
        });
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google account linked successfully!")),
      );

      // Navigate to LoginScreen after Google signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-Up Failed: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "New Account",
          style: TextStyle(
            color: Color(0xFF2F5BEA),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2F5BEA)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              "Create Account",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2F5BEA)),
            ),
            const SizedBox(height: 8),
            const Text(
              "Please fill in the details to create an account",
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 10),

            _buildField("Full Name", "John Doe", _nameController),
            const SizedBox(height: 10),
            _buildField("Email", "example@example.com", _emailController),
            const SizedBox(height: 10),
            _buildField("Mobile Number", "+1 234 567 890", _phoneController),
            const SizedBox(height: 10),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildDOBField(),
            const SizedBox(height: 20),
            _buildTermsText(),
            const SizedBox(height: 25),

            // SIGN-UP BUTTON
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F5BEA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Center(child: Text("or sign up with", style: TextStyle(color: Colors.black54))),
            const SizedBox(height: 20),

            // SOCIAL ICONS (Google triggers Google Sign-Up)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(onTap: _googleSignUp, child: _socialButton(Icons.g_mobiledata)),
                const SizedBox(width: 20),
                _socialButton(Icons.facebook),
                const SizedBox(width: 20),
                _socialButton(Icons.fingerprint),
              ],
            ),

            const SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    children: [
                      TextSpan(
                          text: "Log In",
                          style: TextStyle(
                              color: Color(0xFF2F5BEA), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: false,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFE5E9F5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: "**********",
            filled: true,
            fillColor: const Color(0xFFE5E9F5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDOBField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Date of Birth", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              _dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: _dobController,
              decoration: InputDecoration(
                hintText: "DD/MM/YYYY",
                filled: true,
                fillColor: const Color(0xFFE5E9F5),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsText() {
    return Center(
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "By continuing, you agree to \n ",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          children: [
            TextSpan(
              text: "Terms of Use",
              style: const TextStyle(fontSize: 12, color: Color(0xFF2F5BEA), fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () => print("Terms tapped"),
            ),
            const TextSpan(text: " and ", style: TextStyle(fontSize: 12, color: Colors.black54)),
            TextSpan(
              text: "Privacy Policy",
              style: const TextStyle(fontSize: 12, color: Color(0xFF2F5BEA), fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = () => print("Privacy tapped"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFD6DDF8)),
      child: Icon(icon, color: const Color(0xFF2F5BEA), size: 28),
    );
  }
}
