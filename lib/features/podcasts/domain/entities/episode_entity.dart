import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';

class EpisodeEntity {
  final int id;
  final int podcastId;
  final String contentUrl;
  final String title;
  final int? season;
  final int? number;
  final int? averageRating;
  final String pictureUrl;
  final String description;
  final bool explicit;
  final int duration;
  final String createdAt;
  final String updatedAt;
  final int playCount;
  final int likeCount;
  final PodcastEntity podcast;

  EpisodeEntity({
    required this.id,
    required this.podcastId,
    required this.contentUrl,
    required this.title,
    this.season,
    this.number,
    this.averageRating,
    required this.pictureUrl,
    required this.description,
    required this.explicit,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.playCount,
    required this.likeCount,
    required this.podcast,
  });
}
