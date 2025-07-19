import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AuthCustomTextField extends StatefulWidget {
  final String hint;
  final Icon icon;
  final TextInputType inputType;
  final TextEditingController mycontroller;
  final String? Function(String?)? valid;
  final bool isPassword;

  final Color color;

  const AuthCustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.inputType,
    required this.mycontroller,
    required this.valid,
    this.isPassword = false,
    required this.color,
  });

  @override
  State<AuthCustomTextField> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<AuthCustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: widget.mycontroller,
        keyboardType: widget.inputType,
        obscureText: widget.isPassword ? _obscureText : false,
        validator: widget.valid,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          prefixIconColor: widget.color,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: widget.color,
                    size: 23,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.grey, fontSize: 14),
          filled: true,
          fillColor: isDark ? Colors.grey[850] : const Color(0xFFF3F4F6),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(
                color:
                    isDark ? const Color(0xFF212121) : const Color(0xFFF3F4F6),
                width: 4),
          ),
        ),
      ),
    );
  }
}
