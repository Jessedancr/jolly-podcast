import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/podcasts/data/source/podcast_remote_data_source.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';
import 'package:jolly_podcast/features/podcasts/domain/repo/podcast_repo.dart';

class PodcastRepoImpl extends PodcastRepo {
  final PodcastRemoteDataSource remoteDataSource;

  PodcastRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<String, List<PodcastEntity>>> getTopPodcast() async {
    final result = await remoteDataSource.getTopPodcasts();
    return result;
  }

  @override
  Future<Either<String, List<EpisodeEntity>>> getEpisodesForPodcast({
    required int podcastId,
  }) async {
    final result = await remoteDataSource.getEpisodesForPodcast(
      podcastId: podcastId,
    );
    return result;
  }

  @override
  Future<Either<String, List<EpisodeEntity>>> getTrendingEpisodes() async {
    final result = await remoteDataSource.getTrendingEpisodes();
    return result;
  }
}
