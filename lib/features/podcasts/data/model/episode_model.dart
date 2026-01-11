import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/features/podcasts/data/model/podcast_model.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/episode_entity.dart';

class EpisodeModel extends EpisodeEntity implements Equatable {
  EpisodeModel({
    required super.id,
    required super.podcastId,
    required super.contentUrl,
    required super.title,
    required super.pictureUrl,
    required super.description,
    required super.explicit,
    required super.duration,
    required super.createdAt,
    required super.updatedAt,
    required super.playCount,
    required super.likeCount,
    required super.podcast,
    super.averageRating,
    super.season,
    super.number,
  });

  @override
  List<Object?> get props => [
    id,
    podcastId,
    contentUrl,
    title,
    pictureUrl,
    description,
    explicit,
    duration,
    createdAt,
    updatedAt,
    playCount,
    likeCount,
    podcast,
  ];

  @override
  bool? get stringify => true;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'],
      podcastId: json['podcast_id'],
      contentUrl: json['content_url'],
      title: json['title'],
      pictureUrl: json['picture_url'],
      description: json['description'],
      explicit: json['explicit'],
      duration: json['duration'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      playCount: json['play_count'],
      likeCount: json['like_count'],
      averageRating: json['average_rating'],
      number: json['number'],
      season: json['season'],
      podcast: PodcastModel.fromJson(json['podcast']),
    );
  }
}
