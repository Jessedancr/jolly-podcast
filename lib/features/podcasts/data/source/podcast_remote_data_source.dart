import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/core/network/api_client.dart';
import 'package:jolly_podcast/features/podcasts/data/model/episode_model.dart';
import 'package:jolly_podcast/features/podcasts/data/model/podcast_model.dart';

final ApiClient apiClient = ApiClient();

abstract class PodcastRemoteDataSource {
  Future<Either<String, List<PodcastModel>>> getTopPodcasts();
  Future<Either<String, List<EpisodeModel>>> getEpisodesForPodcast({
    required int podcastId,
  });
  Future<Either<String, List<EpisodeModel>>> getTrendingEpisodes();
}

class PodcastRemoteDataSourceImpl implements PodcastRemoteDataSource {
  @override
  Future<Either<String, List<PodcastModel>>> getTopPodcasts() async {
    try {
      final res = await apiClient.get(endpoint: 'podcasts/top-jolly');
      final resBody = jsonDecode(res.body);

      if (res.statusCode != 200) {
        final String errorMessage = resBody['message'];
        return Left(errorMessage);
      }
      final List<dynamic> podcastsData = resBody['data']['data']['data'] ?? [];
      final List<PodcastModel> podcasts = podcastsData
          .map((podcast) => PodcastModel.fromJson(podcast))
          .toList();
      return Right(podcasts);
    } catch (e) {
      print('Unexpected error fetching podcasts: ${e.toString()}');
      return const Left('Unexpected error. Please try again later.');
    }
  }

  @override
  Future<Either<String, List<EpisodeModel>>> getEpisodesForPodcast({
    required int podcastId,
  }) async {
    try {
      final res = await apiClient.get(endpoint: 'podcasts/$podcastId/episodes');
      final resBody = jsonDecode(res.body);
      if (res.statusCode != 200) {
        final String errorMessage = resBody['message'];
        return Left(errorMessage);
      }

      final List<dynamic> episodesData = resBody['data']['data']['data'] ?? [];
      final List<EpisodeModel> episodes = episodesData
          .map((e) => EpisodeModel.fromJson(e))
          .toList();
      return Right(episodes);
    } catch (e) {
      print('Unexpected error fetching episodes for podcast: ${e.toString()}');
      return const Left('Unexpected error. Please try again');
    }
  }

  @override
  Future<Either<String, List<EpisodeModel>>> getTrendingEpisodes() async {
    try {
      final res = await apiClient.get(endpoint: 'episodes/trending');
      final resBody = jsonDecode(res.body);
      if (res.statusCode != 200) {
        final String errorMessage = resBody['message'];
        return Left(errorMessage);
      }

      final List<dynamic> episodesData = resBody['data']['data']['data'] ?? [];
      final List<EpisodeModel> episodes = episodesData
          .map((e) => EpisodeModel.fromJson(e))
          .toList();
      return Right(episodes);
    } catch (e) {
      print('Unexpected error getting trending episodes: ${e.toString()}');
      return const Left('Unexpected error. Please try again');
    }
  }
}
