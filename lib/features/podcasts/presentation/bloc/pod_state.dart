import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';

class PodState extends Equatable {
  @override
  List<Object?> get props => [];
}

// * Initial state
class PodInitial extends PodState {}

// * Get pods loading
class GetTopPodsLoading extends PodState {}

// * Get pods loaded
class GetTopPodsLoaded extends PodState {
  final List<PodcastEntity> pods;
  GetTopPodsLoaded({required this.pods});
}

// * Get pods error
class GetTopPodsError extends PodState {
  final String message;
  GetTopPodsError({required this.message});
}

// * Get episodes for pods loading
class GetEpisodesForPodLoading extends PodState {}

// * Get episodes for pods Loaded
class GetEpisodesForPodLoaded extends PodState {
  final List<EpisodeEntity> episodes;
  GetEpisodesForPodLoaded({required this.episodes});
}

// * Get episodes for pods error
class GetEpisodesForPodError extends PodState {
  final String message;
  GetEpisodesForPodError({required this.message});
}

// * Get trending episodes loading
class GetTrendingEpisodesLoading extends PodState {}

// * Get trending episodes loaded
class GetTrendingEpisodesLoaded extends PodState {
  final List<EpisodeEntity> episodes;
  GetTrendingEpisodesLoaded({required this.episodes});
}

// * Get trending episodes error
class GetTrendingEpisodesError extends PodState {
  final String message;
  GetTrendingEpisodesError({required this.message});
}
