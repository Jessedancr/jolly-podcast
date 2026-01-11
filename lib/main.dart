import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jolly_podcast/core/constants/color_scheme.dart';
import 'package:jolly_podcast/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:jolly_podcast/features/auth/data/source/auth_remote_data_source.dart';
import 'package:jolly_podcast/features/auth/domain/usecase/login_usecase.dart';
import 'package:jolly_podcast/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jolly_podcast/features/auth/presentation/pages/auth_status.dart';
import 'package:jolly_podcast/features/podcasts/data/repo_impl/podcast_repo_impl.dart';
import 'package:jolly_podcast/features/podcasts/data/source/podcast_remote_data_source.dart';
import 'package:jolly_podcast/features/podcasts/domain/usecase/get_episodes_for_podcast_event.dart';
import 'package:jolly_podcast/features/podcasts/domain/usecase/get_top_podcast_usecase.dart';
import 'package:jolly_podcast/features/podcasts/domain/usecase/get_trending_episodes_usecase.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_bloc.dart';
import 'package:jolly_podcast/features/podcasts/presentation/pages/app.dart';
import 'package:jolly_podcast/features/podcasts/presentation/pages/podcast_episodes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  debugPrint('Base Url: ${dotenv.env['BASE_URL']}');

  // * Login usecase repo and datasource init
  final remoteDataSource = AuthRemoteDataSourceImpl();
  final authRepo = AuthRepoImpl(remoteDataSource: remoteDataSource);
  final login = LoginUsecase(authRepo: authRepo);

  // * Podcasts usecase repo and datasource init
  final podRemoteDataSource = PodcastRemoteDataSourceImpl();
  final podcastRepo = PodcastRepoImpl(remoteDataSource: podRemoteDataSource);
  final getPods = GetTopPodcastUsecase(podcastRepo: podcastRepo);
  final getEpisodesForPods = GetEpisodesForPodcastUsecase(
    podcastRepo: podcastRepo,
  );
  final getTrendingEpisodes = GetTrendingEpisodesUsecase(
    podcastRepo: podcastRepo,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(login: login)),
        BlocProvider(
          create: (context) => PodBloc(
            getTopPods: getPods,
            getEpisodesForPodcast: getEpisodesForPods,
            getTrendingEpisodes: getTrendingEpisodes,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthStatus(),
      theme: appTheme,
      routes: {
        '/home': (context) => const HomePage(),
        '/podcastEpisodes': (context) {
          final podcast =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          final int podcastId = podcast['podcastId'];
          final String podcastTitle = podcast['podcastTitle'];

          return PodcastEpisodes(
            podcastId: podcastId,
            podcastTitle: podcastTitle,
          );
        },
      },
    );
  }
}
