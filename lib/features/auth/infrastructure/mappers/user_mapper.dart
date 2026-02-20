import '../../domain/entities/user.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
    id: json['id'],
    email: json['email'],
    name: json['name'],
    lastName: json['last_name'] ?? json['lastName'] ?? '',
    token: json['token'] ?? '',
  );
}
