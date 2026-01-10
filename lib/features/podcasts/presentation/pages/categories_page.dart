import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/constants/utils.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.secondary,
      body: Center(
        child: Text('CATEGORIES PAGE', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
