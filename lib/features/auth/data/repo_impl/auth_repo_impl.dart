import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/auth/data/source/auth_remote_data_source.dart';
import 'package:jolly_podcast/features/auth/domain/entities/user_entity.dart';
import 'package:jolly_podcast/features/auth/domain/repo/auth_repo.dart';
import 'package:jolly_podcast/features/auth/domain/usecase/login_usecase.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<String, UserEntity>> login({
    required LoginUserParams params,
  }) async {
    final result = await remoteDataSource.login(
      phoneNumber: params.phoneNumber,
      password: params.password,
    );
    return result;
  }
}
