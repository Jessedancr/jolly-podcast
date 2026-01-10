import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jolly_podcast/core/constants/color_scheme.dart';
import 'package:jolly_podcast/core/constants/helpers.dart';
import 'package:jolly_podcast/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:jolly_podcast/features/auth/data/source/auth_remote_data_source.dart';
import 'package:jolly_podcast/features/auth/domain/usecase/login_usecase.dart';
import 'package:jolly_podcast/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jolly_podcast/features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  debugPrint('Base Url: ${dotenv.env['BASE_URL']}');

  // * Login usecase repo and datasource init
  final remoteDataSource = AuthRemoteDataSourceImpl();
  final authRepo = AuthRepoImpl(remoteDataSource: remoteDataSource);
  final login = LoginUsecase(authRepo: authRepo);

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthBloc(login: login))],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage(), theme: appTheme);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: context.colorScheme.primary);
  }
}
