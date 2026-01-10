import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/features/podcasts/domain/entities/podcast_entity.dart';

class PodState extends Equatable {
  @override
  List<Object?> get props => [];
}

// * Initial state
class PodInitial extends PodState {}

// * Get pods loading
class GetPodsLoading extends PodState {}

// * Get pods loaded
class GetPodsLoaded extends PodState {
  final List<PodcastEntity> pods;
  GetPodsLoaded({required this.pods});
}

// * Get pods error
class GetPodsError extends PodState {
  final String message;
  GetPodsError({required this.message});
}
