import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jolly_podcast/core/network/api_client.dart';
import 'package:jolly_podcast/features/auth/data/models/user_model.dart';

final ApiClient apiClient = ApiClient();

abstract class AuthRemoteDataSource {
  Future<Either<String, UserModel>> login({
    required String phoneNumber,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final storage = const FlutterSecureStorage();

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
      print('LOGIN RES BODY: $resBody');

      if (res.statusCode != 200) {
        final errorMessage = resBody['message'];
        return Left(errorMessage);
      }
      final user = resBody['data']['user'];
      final int userId = user['id'];
      final token = resBody['data']['token'];
      await storage.write(key: 'accessToken', value: token);
      await storage.write(key: 'userId', value: userId.toString());

      final userModel = UserModel.fromJson({...user, 'token': token});
      return Right(userModel);
    } catch (e) {
      print('Unexpected error logging in: ${e.toString()}');
      return const Left('Unexpected error. Please try again later.');
    }
  }
}
