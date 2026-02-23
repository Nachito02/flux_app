import 'package:flux_pos/features/auth/domain/domain.dart';
import '../datasource/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({AuthDatasource? datasource})
    : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkStatus(String token) {
    return datasource.checkStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String name, String lastName) {
    return datasource.register(email, password, name, lastName);
  }
}
