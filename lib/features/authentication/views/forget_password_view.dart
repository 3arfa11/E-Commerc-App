import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/core/widgets/custom_text_field.dart';
import 'package:e_commerce/features/authentication/views/otp_view.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

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
            const CustomTextField(
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const OtpView()),
                );
              },
              child: const CustomButton(text: 'Send Code'),
            ),
          ],
        ),
      ),
    );
  }
}
