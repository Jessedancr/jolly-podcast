import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/features/podcasts/domain/usecase/get_episodes_for_podcast_event.dart';
import 'package:jolly_podcast/features/podcasts/domain/usecase/get_top_podcast_usecase.dart';
import 'package:jolly_podcast/features/podcasts/domain/usecase/get_trending_episodes_usecase.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_event.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_state.dart';

class PodBloc extends Bloc<PodEvent, PodState> {
  final GetTopPodcastUsecase getTopPods;
  final GetEpisodesForPodcastUsecase getEpisodesForPodcast;
  final GetTrendingEpisodesUsecase getTrendingEpisodes;

  PodBloc({
    required this.getTopPods,
    required this.getEpisodesForPodcast,
    required this.getTrendingEpisodes,
  }) : super(PodInitial()) {
    on<PodEvent>((event, emit) async {
      if (event is GetTopPodsEvent) {
        emit(GetTopPodsLoading());
        final result = await getTopPods();

        emit(
          result.fold(
            (fail) => GetTopPodsError(message: fail),
            (pods) => GetTopPodsLoaded(pods: pods),
          ),
        );
      } else if (event is GetEpisodesForPodEvent) {
        emit(GetEpisodesForPodLoading());
        final result = await getEpisodesForPodcast(podcastId: event.podcastId);

        emit(
          result.fold(
            (fail) => GetEpisodesForPodError(message: fail),
            (e) => GetEpisodesForPodLoaded(episodes: e),
          ),
        );
      } else if (event is GetTrendingEpisodesEvent) {
        emit(GetTrendingEpisodesLoading());
        final result = await getTrendingEpisodes();

        emit(
          result.fold(
            (fail) => GetTrendingEpisodesError(message: fail),
            (e) => GetTrendingEpisodesLoaded(episodes: e),
          ),
        );
      }
    });
  }
}
