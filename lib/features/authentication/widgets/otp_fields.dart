import 'package:e_commerce/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFields extends StatelessWidget {
  const OtpFields({super.key, required this.index});
  final int index; // Index of the field
  final int otpLength = 6;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        onChanged: (value) {
          // Move focus to next field if not last
          if (value.isNotEmpty && index < otpLength - 1) {
            FocusScope.of(context).nextFocus();
          }
          // Move to previous field if backspace
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Constants.primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1), // Only 1 digit
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
