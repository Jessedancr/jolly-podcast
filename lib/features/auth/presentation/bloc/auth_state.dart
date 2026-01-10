import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/features/auth/domain/entities/user_entity.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

//* Initial state
class AuthInitial extends AuthState {}

// * LOGIN USER STATE
class LoginUserLoading extends AuthState {}

class LoginUserLoaded extends AuthState {
  final UserEntity user;
  LoginUserLoaded({required this.user});
}

class LoginUserError extends AuthState {
  final String message;
  LoginUserError({required this.message});
}
