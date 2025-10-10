import 'package:e_commerce/core/services/firebase_services.dart';
import 'package:e_commerce/core/utils/snackbar_helper.dart';
import 'package:e_commerce/features/authentication/views/forget_password_view.dart';
import 'package:e_commerce/features/authentication/views/sign_up_view.dart';
import 'package:e_commerce/features/authentication/widgets/soical_media_buttons.dart';
import 'package:e_commerce/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/utils/constants.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height, // 👈 ensures it takes full screen height
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 👈 important
              children: [
                // 🔼 Top section (form)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Center(child: Image.asset(Constants.appLogo, width: 100)),
                    const SizedBox(height: 48),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: "Password",
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgetPasswordView(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        // Implement login functionality here
                        try {
                          await FirebaseServices().signInWithEmailAndPassword(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                          showSnackBar(
                            context,
                            'User ${_emailController.text.trim()} Signed In successfully ✅',
                          );
                          final userInfo = await FirebaseServices()
                              .getUserInfo();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeView(userInfo: userInfo),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          String message = "An error occurred";

                          if (e.code == 'invalid-credential') {
                            message = "Wrong credential provided by user.";
                          } else {
                            message = e.message ?? message;
                          }
                          showSnackBar(context, message);
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Constants.primaryColor,
                              ),
                            )
                          : const CustomButton(text: "Login"),
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
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignUpView(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // 🔽 Bottom section (social media)
                const Column(
                  children: [
                    Text(
                      "Login with",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SocialMediaButtons(),
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
