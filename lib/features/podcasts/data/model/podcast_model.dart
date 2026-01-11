import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';

class PodcastModel extends PodcastEntity implements Equatable {
  PodcastModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.author,
    required super.categoryName,
    required super.categoryType,
    required super.pictureUrl,
    required super.coverPictureUrl,
    required super.description,
    required super.createdAt,
    required super.updatedAt,
    required super.subscriberCount,
    required super.publisher,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    title,
    author,
    categoryName,
    categoryType,
    pictureUrl,
    coverPictureUrl,
    description,
    createdAt,
    updatedAt,
    subscriberCount,
    publisher,
  ];

  @override
  bool? get stringify => true;

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      author: json['author'],
      categoryName: json['category_name'],
      categoryType: json['category_type'],
      pictureUrl: json['picture_url'],
      coverPictureUrl: json['cover_picture_url'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      subscriberCount: json['subscriber_count'] ?? 0,
      publisher: json['publisher'],
    );
  }
}
