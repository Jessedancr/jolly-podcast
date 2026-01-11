import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/features/podcasts/domain/repo/podcast_repo.dart';

class GetEpisodesForPodcastUsecase {
  final PodcastRepo podcastRepo;

  GetEpisodesForPodcastUsecase({required this.podcastRepo});

  Future<Either<String, List<EpisodeEntity>>> call({
    required int podcastId,
  }) async {
    return await podcastRepo.getEpisodesForPodcast(podcastId: podcastId);
  }
}
