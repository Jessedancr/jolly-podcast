import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/features/auth/domain/usecase/login_usecase.dart';
import 'package:jolly_podcast/features/auth/presentation/bloc/auth_event.dart';
import 'package:jolly_podcast/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase login;
  AuthBloc({required this.login}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginUserEvent) {
        emit(LoginUserLoading());
        final result = await login(
          params: LoginUserParams(
            phoneNumber: event.phoneNumber,
            password: event.password,
          ),
        );

        emit(
          result.fold(
            (fail) => LoginUserError(message: fail),
            (user) => LoginUserLoaded(user: user),
          ),
        );
      }
    });
  }
}
