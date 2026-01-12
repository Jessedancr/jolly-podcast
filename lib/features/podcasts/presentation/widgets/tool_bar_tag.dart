import 'package:flutter/material.dart';

class ToolBarTag extends StatelessWidget {
  const ToolBarTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 13),
      decoration: BoxDecoration(
        color: Color(0XFF3E3E3E).withOpacity(0.5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/dummy_avatar.png'),
          const SizedBox(width: 10),
          Icon(Icons.notifications, color: Colors.white),
          const SizedBox(width: 10),

          Icon(Icons.search, color: Colors.white),
        ],
      ),
    );
  }
}
