// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class OTPPage extends StatefulWidget {
//   const OTPPage({super.key});
//
//   @override
//   State<OTPPage> createState() => _OTPPageState();
// }
//
// class _OTPPageState extends State<OTPPage> {
//   final int otpLength = 6;
//   final List<TextEditingController> _controllers = [];
//   final List<bool> _filled = [];
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < otpLength; i++) {
//       _controllers.add(TextEditingController());
//       _filled.add(false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Enter OTP")),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(otpLength, (index) {
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 550),
//               curve: Curves.easeInOut,
//               width: 50,
//               height: 60,
//               margin: const EdgeInsets.symmetric(horizontal: 6),
//               decoration: BoxDecoration(
//                 color: _filled[index]
//                     ? Colors.blue.withOpacity(0.1)
//                     : Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//                   color: _filled[index] ? Colors.blue : Colors.grey,
//                   width: 2,
//                 ),
//               ),
//               child: TextField(
//                 controller: _controllers[index],
//                 onChanged: (value) {
//                   setState(() {
//                     _filled[index] = value.isNotEmpty;
//                   });
//
//                   // Move to next
//                   if (value.isNotEmpty && index < otpLength - 1) {
//                     FocusScope.of(context).nextFocus();
//                   }
//
//                   // Move to previous on delete
//                   if (value.isEmpty && index > 0) {
//                     FocusScope.of(context).previousFocus();
//                   }
//                 },
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 18),
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   LengthLimitingTextInputFormatter(1),
//                   FilteringTextInputFormatter.digitsOnly,
//                 ],
//                 decoration: const InputDecoration(border: InputBorder.none),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
