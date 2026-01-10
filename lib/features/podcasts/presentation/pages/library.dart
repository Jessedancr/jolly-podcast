import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/constants/utils.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.secondary,
      body: Center(
        child: Text('LIBRARY', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
