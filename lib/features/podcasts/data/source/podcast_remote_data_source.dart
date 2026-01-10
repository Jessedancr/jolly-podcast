import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/core/network/api_client.dart';
import 'package:jolly_podcast/features/podcasts/data/model/podcast_model.dart';

final ApiClient apiClient = ApiClient();

abstract class PodcastRemoteDataSource {
  Future<Either<String, List<PodcastModel>>> getPodcasts();
}

class PodcastRemoteDataSourceImpl implements PodcastRemoteDataSource {
  @override
  Future<Either<String, List<PodcastModel>>> getPodcasts() async {
    try {
      final res = await apiClient.get(endpoint: 'podcasts/top-jolly');
      final resBody = jsonDecode(res.body);

      print('PODCASTS RES BODY: $resBody');

      if (res.statusCode != 200) {
        final String errorMessage = resBody['message'];
        return Left(errorMessage);
      }
      final podcastModel = PodcastModel.fromJson(resBody);
      return Right([podcastModel]);
    } catch (e) {
      print('Unexpected error fetching podcasts: ${e.toString()}');
      return const Left('Unexpected error. Please try again later.');
    }
  }
}
