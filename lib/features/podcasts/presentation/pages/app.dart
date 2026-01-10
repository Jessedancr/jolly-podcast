import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/constants/utils.dart';
import 'package:jolly_podcast/features/podcasts/presentation/pages/categories_page.dart';
import 'package:jolly_podcast/features/podcasts/presentation/pages/discover_page.dart';
import 'package:jolly_podcast/features/podcasts/presentation/pages/library.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0; // To track the index of the nav bar
  List<Widget> screens = [DiscoverPage(), CategoriesPage(), Library()];

  // METHOD TO NAVIGATE NAV BAR
  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.colorScheme.secondary,
        body: IndexedStack(index: selectedIndex, children: screens),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: selectedIndex,
          navigateBottomBar: navigateBottomBar,
        ),
      ),
    );
  }
}
