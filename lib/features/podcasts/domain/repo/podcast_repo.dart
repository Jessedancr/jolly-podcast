import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';

abstract class PodcastRepo {
  Future<Either<String, List<PodcastEntity>>> getTopPodcast();
  Future<Either<String, List<EpisodeEntity>>> getEpisodesForPodcast({
    required int podcastId,
  });
  Future<Either<String, List<EpisodeEntity>>> getTrendingEpisodes();
}
