import 'package:e_commerce/core/services/firebase_services.dart';
import 'package:e_commerce/core/utils/snackbar_helper.dart';
import 'package:e_commerce/features/authentication/views/login_view.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Constants.appLogo, width: 50),
                const SizedBox(height: 48),
                const Row(
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Username',
                  controller: _usernameController,
                  prefixIcon: Icons.person_2_outlined,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Email',
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Phone Number',
                  controller: _phoneController,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: "Password",
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                ),
                const SizedBox(height: 16),
                const CustomTextField(
                  hintText: "Confirm Password",
                  prefixIcon: Icons.lock_outline,
                ),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      FirebaseServices().signUp(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        _usernameController.text.trim(),
                        _phoneController.text.trim(),
                      );

                      showSnackBar(
                        context,
                        'User ${_usernameController.text.trim()} registered successfully ✅',
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      String message = 'Something went wrong';
                      if (e.code == 'email-already-in-use') {
                        message = 'This email is already in use';
                      } else if (e.code == 'weak-password') {
                        message = 'The password is too weak';
                      }
                      showSnackBar(context, message);
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const CustomButton(text: "Sign Up"),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      "Or",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        endIndent: 10,
                        indent: 8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade200,
                      child: IconButton(
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                          size: 26,
                        ),
                        onPressed: () {
                          // Handle Facebook login
                        },
                      ),
                    ),
                    const SizedBox(width: 25),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade200,
                      child: IconButton(
                        icon: const Icon(
                          Icons.g_mobiledata,
                          color: Colors.red,
                          size: 28,
                        ),
                        onPressed: () {
                          // Handle Google login
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
