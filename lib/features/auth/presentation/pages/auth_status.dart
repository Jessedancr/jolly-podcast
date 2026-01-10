import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/constants/utils.dart';
import 'package:jolly_podcast/features/auth/presentation/pages/login_page.dart';
import 'package:jolly_podcast/features/podcasts/presentation/pages/app.dart';

class AuthStatus extends StatefulWidget {
  const AuthStatus({super.key});

  @override
  State<AuthStatus> createState() => _AuthStatusState();
}

class _AuthStatusState extends State<AuthStatus> {
  final AppSecureStorage _appSecureStorage = AppSecureStorage();
  late Future<bool> _checkAuthStatus;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus = _appSecureStorage.isTokenAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const LoginPage();
        }

        if (snapshot.data == true) {
          return const HomePage();
        }

        return const LoginPage();
      },
    );
  }
}
