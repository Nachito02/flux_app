import 'package:dio/dio.dart';
import 'package:flux_pos/config/constants/environment.dart';
import 'package:flux_pos/features/auth/domain/domain.dart';
import 'package:flux_pos/features/auth/infrastructure/mappers/user_mapper.dart';

final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

class AuthDatasourceImpl extends AuthDatasource {
  @override
  Future<User> checkStatus(String token) async {
    try {
      final response = await dio.get(
        '/auth/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data as Map<String, dynamic>;
      final rawUserJson = (data['user'] ?? data) as Map<String, dynamic>;
      final userJson = <String, dynamic>{...rawUserJson};
      userJson['token'] ??= token;

      final user = UserMapper.userJsonToEntity(userJson);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Token incorrecto');
      }
      throw Exception();
    } catch (e) {

      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final data = response.data as Map<String, dynamic>;
      final userJson = (data['user'] ?? data) as Map<String, dynamic>;
      final user = UserMapper.userJsonToEntity(userJson);

      return user;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password) {
    throw UnimplementedError();
  }
}
