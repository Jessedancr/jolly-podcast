import 'package:flutter/material.dart';

class PodcastTileCtaButton extends StatelessWidget {
  final Widget icon;
  const PodcastTileCtaButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: icon,
    );
  }
}
