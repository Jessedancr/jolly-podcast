import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioCtaTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final bool? reversed;
  const AudioCtaTile({
    super.key,
    required this.icon,
    required this.title,
    this.reversed = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Color(0XFFE4E4E4), width: 2.0),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (reversed!) ...[
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFFE4E4E4),
                ),
              ),
              const SizedBox(width: 7),
              icon,
            ] else ...[
              icon,
              const SizedBox(width: 7),
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFFE4E4E4),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
