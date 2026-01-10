import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int)? navigateBottomBar;
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.navigateBottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: navigateBottomBar,
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0XFFA5A5A5),
      backgroundColor: Color(0XFF2f2f2f),
      selectedLabelStyle: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      unselectedLabelStyle: GoogleFonts.nunito(
        fontSize: 14,
        color: Color(0XFFA5A5A5),
        fontWeight: FontWeight.w500,
      ),
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svg/discover_icon.svg'),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svg/categories_icon.svg'),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svg/library_icon.svg'),
          label: 'Your Library',
        ),
      ],
    );
  }
}
