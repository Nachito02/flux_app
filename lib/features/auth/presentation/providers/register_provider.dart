// !State de este provider
import 'package:flutter_riverpod/legacy.dart';
import 'package:flux_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flux_pos/features/shared/infrastructure/inputs/last_name.dart';
import 'package:flux_pos/features/shared/infrastructure/inputs/name.dart';
import 'package:flux_pos/features/shared/shared.dart';
import 'package:formz/formz.dart';

//! State notifier porivider - consume afuera

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((
      ref,
    ) {
      final registerUserCallback = ref
          .watch(authProvider.notifier)
          .registerUser;
      return RegisterFormNotifier(registerUserCallback: registerUserCallback);
    });

class RegisterFormState {
  final bool isPosting;

  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final Name name;
  final LastName lastName;
  final Password confirmPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const Name.pure(),
    this.lastName = const LastName.pure(),
    this.confirmPassword = const Password.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    Name? name,
    LastName? lastName,
    Password? confirmPassword,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
    name: name ?? this.name,
    lastName: lastName ?? this.lastName,
    confirmPassword: confirmPassword ?? this.confirmPassword,
  );

  @override
  String toString() {
    return '''
    LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
    name: $name
    lastName: $lastName
    confirmPassword: $confirmPassword
    ''';
  }
}

//! Como implementamos un notifier

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String, String, String) registerUserCallback;
  RegisterFormNotifier({required this.registerUserCallback})
    : super(RegisterFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);

    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([
        newEmail,
        state.password,
        state.name,
        state.lastName,
        state.confirmPassword,
      ]),
    );
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([
        newPassword,
        state.email,
        state.name,
        state.lastName,
        state.confirmPassword,
      ]),
    );
  }

  onNameChange(String value) {
    final newName = Name.dirty(value);

    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([
        newName,
        state.email,
        state.password,
        state.lastName,
        state.confirmPassword,
      ]),
    );
  }

  onLastNameChange(String value) {
    final newLastName = LastName.dirty(value);
    state = state.copyWith(
      lastName: newLastName,
      isValid: Formz.validate([
        newLastName,
        state.email,
        state.password,
        state.name,
        state.confirmPassword,
      ]),
    );
  }

  onConfirmPasswordChange(String value) {
    final newConfirmPassword = Password.dirty(value);
    state = state.copyWith(
      confirmPassword: newConfirmPassword,
      isValid: Formz.validate([
        newConfirmPassword,
        state.email,
        state.password,
        state.name,
        state.lastName,
      ]),
    );
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    await registerUserCallback(
      state.email.value,
      state.password.value,
      state.name.value,
      state.lastName.value,
      state.confirmPassword.value,
    );

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final name = Name.dirty(state.name.value);
    final lastName = LastName.dirty(state.lastName.value);
    final confirmPassword = Password.dirty(state.confirmPassword.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      name: name,
      lastName: lastName,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([
        email,
        password,
        name,
        lastName,
        confirmPassword,
      ]),
    );
  }
}
