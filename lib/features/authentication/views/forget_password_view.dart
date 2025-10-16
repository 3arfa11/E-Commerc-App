import 'package:e_commerce/core/services/firebase_services.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/snackbar_helper.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/core/widgets/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forget Password'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/forget_password.jpg'),
            const SizedBox(height: 10),
            const Row(
              children: [
                Text(
                  'Reset password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Constants.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _emailController,
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                String email = _emailController.text.trim();
                final Uri gmailUri = Uri.parse("https://mail.google.com/");

                final error = await FirebaseServices().resetPassword(email);
                if (error == null) {
                  showSnackBar(context, "Email sent! Check your inbox.");
                } else {
                  showSnackBar(context, error);
                }
                await Future.delayed(const Duration(milliseconds: 1400));
                if (await canLaunchUrl(gmailUri)) {
                  await launchUrl(
                    gmailUri,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  showSnackBar(context, "Could not open Gmail.");
                }
              },
              child: const CustomButton(text: 'Send Code'),
            ),
          ],
        ),
      ),
    );
  }
}
