import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/widgets/custom_button.dart';
import 'package:e_commerce/features/authentication/widgets/otp_fields.dart';
import 'package:flutter/material.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});
  final int otpLength = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/otp_image.png',
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              const Text(
                "Enter your OTP code here",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(otpLength, (index) {
                  return OtpFields(index: index);
                }),
              ),
              const SizedBox(height: 20),
              const CustomButton(text: "Verify"),
              const SizedBox(height: 20),
              const Text("Didn't receive the code?"),
              const SizedBox(height: 10),
              const Text(
                "Resend new code",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Constants.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
