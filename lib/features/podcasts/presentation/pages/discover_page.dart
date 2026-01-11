import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/core/constants/utils.dart';
import 'package:jolly_podcast/core/widgets/snackbars.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_bloc.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_event.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_state.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/episode_tile.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/tool_bar_tag.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/top_jolly_tile.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool isLoading = true;
  List<PodcastEntity> podcasts = [];
  List<EpisodeEntity> episodes = [];

  @override
  void initState() {
    getPodCasts();
    super.initState();
  }

  void getPodCasts() {
    context.read<PodBloc>().add(GetTopPodsEvent());
    context.read<PodBloc>().add(GetTrendingEpisodesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<PodBloc, PodState>(
        // * LISTENER
        listener: (context, state) {
          if (state is GetTopPodsLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is GetTopPodsError) {
            setState(() {
              isLoading = false;
            });
            showErrorSnackBar(context, state.message);
          } else if (state is GetTopPodsLoaded) {
            setState(() {
              isLoading = false;
              podcasts = state.pods;
            });
            debugPrint('PODCASTS LENGTH: ${state.pods.length}');
          } else if (state is GetTrendingEpisodesLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is GetTrendingEpisodesError) {
            setState(() {
              isLoading = false;
            });
            showErrorSnackBar(context, state.message);
          } else if (state is GetTrendingEpisodesLoaded) {
            setState(() {
              isLoading = false;
              episodes = state.episodes;
            });
          }
        },

        // * CHILD WIDGET
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 65,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/app_logo_image.png', height: 50),
                ToolBarTag(),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Column(
                        children: [
                          // * HOT AND TRENDING EPISODES
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/fire.png'),
                              const SizedBox(width: 8),
                              Text(
                                'Hot & trending episodes',
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 17),

                          // * TRENDING EPISODES TILE
                          SizedBox(
                            height: context.screenHeight * 0.44,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: episodes.length,
                              itemBuilder: (context, index) {
                                final episode = episodes[index];
                                return EpisodeTile(
                                  podTitle: episode.podcast.title,
                                  episodeTitle: episode.title,
                                  description: episode.description,
                                  pictureUrl: episode.pictureUrl,
                                  onTap: () {},
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 34),

                          // * TOP JOLLY TILE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Top Jolly',
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 17),
                          SizedBox(
                            height: context.screenHeight * 0.35,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: podcasts.length,
                              itemBuilder: (context, index) {
                                final podcast = podcasts[index];
                                return TopJollyTile(
                                  author: podcast.author,
                                  title: podcast.title,
                                  pictureUrl: podcast.pictureUrl,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/podcastEpisodes',
                                      arguments: {
                                        'podcastId': podcast.id,
                                        'podcastTitle': podcast.title,
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
