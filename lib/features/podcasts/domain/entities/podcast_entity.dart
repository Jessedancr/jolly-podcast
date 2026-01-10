class PodcastEntity {
  final int id;
  final int userId;
  final String title;
  final String author;
  final String categoryName;
  final String categoryType;
  final String pictureUrl;
  final String coverPictureUrl;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int subscriberCount;
  final Map<String, dynamic> publisher;

  PodcastEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.author,
    required this.categoryName,
    required this.categoryType,
    required this.pictureUrl,
    required this.coverPictureUrl,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.subscriberCount,
    required this.publisher,
  });
}
