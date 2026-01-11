import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';
import 'package:jolly_podcast/features/podcasts/domain/repo/podcast_repo.dart';

class GetTopPodcastUsecase {
  final PodcastRepo podcastRepo;

  const GetTopPodcastUsecase({required this.podcastRepo});

  Future<Either<String, List<PodcastEntity>>> call() async {
    return await podcastRepo.getTopPodcast();
  }
}
