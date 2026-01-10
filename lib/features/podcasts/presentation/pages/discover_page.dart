import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jolly_podcast/core/constants/utils.dart';
import 'package:jolly_podcast/core/widgets/snackbars.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_bloc.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_event.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_state.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/podcast_tile.dart';
import 'package:jolly_podcast/features/podcasts/presentation/widgets/tool_bar_tag.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool isLoading = false;
  List<PodcastEntity> podcasts = [];

  @override
  void initState() {
    getPodCasts();
    super.initState();
  }

  void getPodCasts() {
    context.read<PodBloc>().add(GetPodsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<PodBloc, PodState>(
        // * LISTENER
        listener: (context, state) {
          if (state is GetPodsLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is GetPodsError) {
            setState(() {
              isLoading = false;
            });
            showErrorSnackBar(context, state.message);
          } else if (state is GetPodsLoaded) {
            setState(() {
              isLoading = false;
              podcasts = state.pods;
            });
            showSuccessSnackBar(context, 'Podcasts fetched!');
            debugPrint('PODCASTS LENGTH: ${state.pods.length}');
          }
        },

        // * CHILD WIDGET
        child: Scaffold(
          backgroundColor: context.colorScheme.secondary,
          appBar: AppBar(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: isLoading
                ? const Center(child: LinearProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: context.screenHeight * 0.06),
                        // * Heading
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/fire.png'),
                            const SizedBox(width: 8),
                            Text(
                              'Hot & trending episodes',
                              style: GoogleFonts.nunito(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 17),

                        SizedBox(
                          height: context.screenHeight * 0.44,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: podcasts.length,
                            itemBuilder: (context, index) {
                              final podcast = podcasts[index];
                              return PodcastTile(
                                author: podcast.author,
                                title: podcast.title,
                                description: podcast.description,
                                pictureUrl: podcast.pictureUrl,
                                onTap: () {},
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
    );
  }
}
