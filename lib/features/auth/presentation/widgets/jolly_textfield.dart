// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/core/constants/helpers.dart';

class JollyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final BorderRadius borderRadius;
  final String hintText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const JollyTextfield({
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(32)),
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(fontSize: 16, color: Color(0XFF5A5A5A)),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.colorScheme.primary,
            width: 2.0,
          ),
          borderRadius: borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.secondary),
          borderRadius: borderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.error),
          borderRadius: borderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.error, width: 2.0),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
