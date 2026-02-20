import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Password extends FormzInput<String, PasswordError> {
  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  // ignore: use_super_parameters
  const Password.dirty(String value) : super.dirty(value);

   String? get errorMessage {

    if( isValid || isPure ) return null;
    if( displayError == PasswordError.empty ) return 'La contraseña es obligatoria';
    if( displayError == PasswordError.length ) return 'La contraseña debe tener al menos 6 caracteres';

    return null;

  }

  // Override validator to handle validating a given input value.
  @override
  PasswordError? validator(String value) {
    if(value.isEmpty || value.trim().isEmpty) return PasswordError.empty;

    if(value.length <6 ) return PasswordError.length;
    return value.isEmpty ? PasswordError.empty : null;
  }

}