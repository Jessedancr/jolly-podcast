import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/core/widgets/snackbars.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_bloc.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_event.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_state.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/episode_tile.dart';

class PodcastEpisodes extends StatefulWidget {
  final int podcastId;
  final String podcastTitle;
  const PodcastEpisodes({
    super.key,
    required this.podcastId,
    required this.podcastTitle,
  });

  @override
  State<PodcastEpisodes> createState() => _PodcastEpisodesState();
}

class _PodcastEpisodesState extends State<PodcastEpisodes> {
  bool isLoading = true;
  List<EpisodeEntity> episodes = [];

  @override
  void initState() {
    getEpisodes();
    super.initState();
  }

  void getEpisodes() {
    context.read<PodBloc>().add(
      GetEpisodesForPodEvent(podcastId: widget.podcastId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<PodBloc, PodState>(
        // * LISTENER
        listener: (context, state) {
          if (state is GetEpisodesForPodLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is GetEpisodesForPodError) {
            setState(() {
              isLoading = false;
            });
            showErrorSnackBar(context, state.message);
          } else if (state is GetEpisodesForPodLoaded) {
            setState(() {
              isLoading = false;
              episodes = state.episodes;
            });
          }
        },

        // * CHILD WIDGET
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: BackButton(color: Colors.white),
            title: Text(
              'Podcast Episodes',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: episodes.length,
                  itemBuilder: (context, index) {
                    final e = episodes[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: EpisodeTile(
                        podTitle: widget.podcastTitle,
                        description: e.description,
                        episodeTitle: e.title,
                        pictureUrl: e.pictureUrl,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/audioPage',
                            arguments: {
                              'contentUrl': e.contentUrl,
                              'pictureUrl': e.pictureUrl,
                              'description': e.description,
                              'title': e.title,
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
