import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity implements Equatable {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.email,
    required super.jollyEmail,
    required super.country,
    required super.personalizations,
    required super.token,
    required super.createdAt,
    required super.updatedAt,
  });
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    phoneNumber,
    email,
    jollyEmail,
    country,
    personalizations,
    token,
    createdAt,
    updatedAt,
  ];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      jollyEmail: json['jolly_email'],
      country: json['country'],
      personalizations: json['personalizations'],
      token: json['token'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'jolly_email': jollyEmail,
      'country': country,
      'personalizations': personalizations,
      'token': token,
    };
  }
}
