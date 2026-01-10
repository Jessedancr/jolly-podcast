import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/features/podcasts/domain/usecase/get_podcast_usecase.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_event.dart';
import 'package:jolly_podcast/features/podcasts/presentation/bloc/pod_state.dart';

class PodBloc extends Bloc<PodEvent, PodState> {
  final GetPodcastUsecase getPods;

  PodBloc({required this.getPods}) : super(PodInitial()) {
    on<PodEvent>((event, emit) async {
      if (event is GetPodsEvent) {
        emit(GetPodsLoading());
        final result = await getPods();

        emit(
          result.fold(
            (fail) => GetPodsError(message: fail),
            (pods) => GetPodsLoaded(pods: pods),
          ),
        );
      }
    });
  }
}
