import 'package:assign_app/FirebaseService/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login_ui.dart';
// Make sure to import the FirebaseService

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseService _firebaseService = FirebaseService();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _agreeToTerms = true;

  Future<void> _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    if (!_agreeToTerms) {
      _showErrorDialog('You must agree to the terms and conditions');
      return;
    }

    try {
      User? user = await _firebaseService.signUpWithEmailPassword(email, password);
      if (user != null) {
        await _firebaseService.addUserData(user.uid, {
          'fullName': _fullNameController.text.trim(),
          'phone': _phoneController.text.trim(),
          'email': email,
        });

        // Show success message with SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Account created successfully!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate to login page or home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (e) {
      _showErrorDialog('Sign Up Error: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/images/arrow_back.png'),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
        title: const Text(
          'Sign Up',
          style: TextStyle(fontFamily: 'Supermercado'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(size.width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: size.width * 0.15,
                        backgroundColor: Colors.pink[50],
                        child: Icon(
                          Icons.camera_alt,
                          size: size.width * 0.1,
                          color: const Color.fromARGB(255, 252, 133, 6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        controller: _fullNameController,
                        decoration: const InputDecoration(
                           filled: true,
                        fillColor: Color.fromARGB(231, 199, 255, 195),
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                           filled: true,
                        fillColor: Color.fromARGB(231, 199, 255, 195),
                          labelText: 'Phone number',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                           filled: true,
                        fillColor: Color.fromARGB(231, 199, 255, 195),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                           filled: true,
                        fillColor: Color.fromARGB(231, 199, 255, 195),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                           filled: true,
                        fillColor: Color.fromARGB(231, 199, 255, 195),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                      title: const Text(
                        'By creating an account you agree to our terms of service and privacy policy',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(251, 51, 26, 1),
                            Color.fromRGBO(247, 108, 46, 1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02,
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'Supermercado',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: ' Sign In',
                              style: const TextStyle(
                                color: Color.fromRGBO(250, 77, 36, 1),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
