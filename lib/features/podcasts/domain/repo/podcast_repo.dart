import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';

abstract class PodcastRepo {
  Future<Either<String, List<PodcastEntity>>> getPodcast();
}
