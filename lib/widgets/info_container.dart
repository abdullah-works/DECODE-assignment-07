import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.backgroundColor,
    required this.text,
    this.fontSize,
    this.foregroundColor,
  });

  final Color backgroundColor;
  final String text;
  final double? fontSize;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 15,
          fontWeight: FontWeight.w500,
          color: foregroundColor ?? Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
