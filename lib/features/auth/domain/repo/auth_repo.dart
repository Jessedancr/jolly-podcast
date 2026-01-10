import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/features/auth/domain/entities/user_entity.dart';
import 'package:jolly_podcast/features/auth/domain/usecase/login_usecase.dart';

abstract class AuthRepo {
  Future<Either<String, UserEntity>> login({required LoginUserParams params});
}
