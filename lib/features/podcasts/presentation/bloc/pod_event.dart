import 'package:equatable/equatable.dart';

class PodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTopPodsEvent extends PodEvent {}

class GetEpisodesForPodEvent extends PodEvent {
  final int podcastId;
  GetEpisodesForPodEvent({required this.podcastId});
}

class GetTrendingEpisodesEvent extends PodEvent {}
