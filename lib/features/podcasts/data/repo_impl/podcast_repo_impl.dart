import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/podcasts/data/source/podcast_remote_data_source.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';
import 'package:jolly_podcast/features/podcasts/domain/repo/podcast_repo.dart';

class PodcastRepoImpl extends PodcastRepo {
  final PodcastRemoteDataSource remoteDataSource;

  PodcastRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<String, List<PodcastEntity>>> getPodcast() async {
    final result = await remoteDataSource.getPodcasts();
    return result;
  }
}
