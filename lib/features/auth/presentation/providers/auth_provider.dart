import 'package:flutter_riverpod/legacy.dart';
import 'package:flux_pos/features/auth/domain/domain.dart';
import 'package:flux_pos/features/auth/infrastructure/infrasctructure.dart';
import 'package:flux_pos/features/shared/shared.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  final keyValueStorageService = KeyValueStorageImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(microseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registerUser(String email, String password, String fullName) async {}

  Future<void> checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) return logout();

    try {
      final user = await authRepository.checkStatus(token);

      _setLoggedUser(user);
    } on CustomError catch (e) {
      await logout(e.message);
    } catch (e) {
      await logout('Sesion expirada');
    }
  }

  Future<void> logout([String? errorMessage]) async {
    // await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue('token', user.token);

    //todo: Necesito guardar el token fisicamente
    state = state.copyWith(
      user: user,
      errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
