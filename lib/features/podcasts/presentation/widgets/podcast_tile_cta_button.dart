import 'package:flutter/material.dart';

class PodcastTileCtaButton extends StatelessWidget {
  final Widget icon;
  const PodcastTileCtaButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Center(child: icon),
    );
  }
}
