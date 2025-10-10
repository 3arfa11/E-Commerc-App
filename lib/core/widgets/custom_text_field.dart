import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.controller,
    this.validator,
  });
  final String? hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xffe5383b), width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xffa4161a), width: 2.0),
        ),
        hintText: hintText ?? 'Enter text',
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        contentPadding: prefixIcon != null
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 14)
            : null, // Reset padding when no icon
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.black87),
      cursorColor: Colors.blue,
    );
  }
}
