import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends AuthEvent {
  final String phoneNumber;
  final String password;

  LoginUserEvent({required this.phoneNumber, required this.password});
}
