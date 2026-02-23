import '../entities/user.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);

  Future<User> register(String email, String password, String name, String lastName);

  Future<User> checkStatus(String token);
}
