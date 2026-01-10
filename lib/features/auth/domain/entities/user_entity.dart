class UserEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String jollyEmail;
  final String country;
  final List<dynamic> personalizations;
  final String token;
  final String createdAt;
  final String updatedAt;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.jollyEmail,
    required this.country,
    required this.personalizations,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
  });
}
