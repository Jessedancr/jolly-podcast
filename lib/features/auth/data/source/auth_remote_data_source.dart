import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:jolly_podcast/core/constants/utils.dart';
import 'package:jolly_podcast/core/network/api_client.dart';
import 'package:jolly_podcast/features/auth/data/models/user_model.dart';

final ApiClient apiClient = ApiClient();
final AppSecureStorage appSecureStorage = AppSecureStorage();

abstract class AuthRemoteDataSource {
  Future<Either<String, UserModel>> login({
    required String phoneNumber,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<String, UserModel>> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final res = await apiClient.authPost(
        endpoint: 'auth/login',
        body: {'phone_number': phoneNumber, 'password': password},
      );
      final resBody = jsonDecode(res.body);

      if (res.statusCode != 200) {
        final errorMessage = resBody['message'];
        return Left(errorMessage);
      }
      final user = resBody['data']['user'];
      final int userId = user['id'];
      final token = resBody['data']['token'];

      await appSecureStorage.saveToken(token);
      await appSecureStorage.saveUserId(userId.toString());

      final userModel = UserModel.fromJson({...user, 'token': token});
      return Right(userModel);
    } catch (e) {
      print('Unexpected error logging in: ${e.toString()}');
      return const Left('Unexpected error. Please try again later.');
    }
  }
}
