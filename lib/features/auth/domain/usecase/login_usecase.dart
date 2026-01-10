import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/features/auth/domain/entities/user_entity.dart';
import 'package:jolly_podcast/features/auth/domain/repo/auth_repo.dart';

class LoginUsecase {
  final AuthRepo authRepo;

  const LoginUsecase({required this.authRepo});

  Future<Either<String, UserEntity>> call({
    required LoginUserParams params,
  }) async {
    return await authRepo.login(params: params);
  }
}

class LoginUserParams extends Equatable {
  final String phoneNumber;
  final String password;

  const LoginUserParams({required this.phoneNumber, required this.password});

  @override
  List<Object?> get props => [phoneNumber, password];
}
