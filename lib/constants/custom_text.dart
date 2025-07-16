import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class Customtextfields extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final TextEditingController mycontroller;
  final String? Function(String?)? valid;
  final bool isPassword;

  const Customtextfields({
    super.key,
    required this.hint,
    required this.inputType,
    required this.mycontroller,
    required this.valid,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: mycontroller,
        keyboardType: inputType,
        obscureText: isPassword,
        validator: valid,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey, fontSize: 14),
          filled: true,
          fillColor: isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
