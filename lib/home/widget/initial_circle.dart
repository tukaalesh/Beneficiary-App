import 'package:charity_app/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class Initialcircle extends StatelessWidget {
  const Initialcircle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
 
    final colorScheme = context.colorScheme;
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.primary,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
