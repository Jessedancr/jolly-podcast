import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/core/widgets/touchable_opacity.dart';

class AuthButton extends StatefulWidget {
  final void Function()? onTap;
  final String buttonText;
  final bool isLoading;
  const AuthButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.isLoading = false,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Color(0XFF003334),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: widget.isLoading
              ? CircularProgressIndicator()
              : Text(
                  widget.buttonText,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
