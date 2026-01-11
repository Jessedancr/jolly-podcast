import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/features/podcasts/domain/repo/podcast_repo.dart';

class GetTrendingEpisodesUsecase {
  final PodcastRepo podcastRepo;

  const GetTrendingEpisodesUsecase({required this.podcastRepo});

  Future<Either<String, List<EpisodeEntity>>> call() async {
    return await podcastRepo.getTrendingEpisodes();
  }
}
