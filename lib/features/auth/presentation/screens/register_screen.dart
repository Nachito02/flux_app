import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_pos/features/auth/presentation/providers/providers.dart';
import 'package:flux_pos/features/auth/presentation/widgets/custom_filled_button.dart';
import 'package:flux_pos/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flux_pos/features/auth/presentation/widgets/geometrical_background.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                // Icon Banner
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (!context.canPop()) return;
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(flex: 1),
                   
                    Text(
                      'Crear cuenta',
                      style: textStyles.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),

                const SizedBox(height: 15),

                Container(
                  height: size.height - 150,// 80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: const _RegisterForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;

      showSnackBar(context, next.errorMessage);
    });

    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        
        children: [
          const SizedBox(height: 20),
          Text('Nueva cuenta', style: textStyles.titleMedium),
          const SizedBox(height: 20),
          CustomTextFormField(
            onFieldSubmitted: (_) =>
                ref.read(registerFormProvider.notifier).onFormSubmit(),
            errorMessage: registerForm.isFormPosted
                ? registerForm.name.errorMessage
                : null,
            onChanged: ref.read(registerFormProvider.notifier).onNameChange,
            label: 'Nombre',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 30),

          CustomTextFormField(
            onFieldSubmitted: (_) =>
                ref.read(registerFormProvider.notifier).onFormSubmit(),
            errorMessage: registerForm.isFormPosted
                ? registerForm.lastName.errorMessage
                : null,
            onChanged: ref.read(registerFormProvider.notifier).onLastNameChange,
            label: 'Apellido',
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 30),

          CustomTextFormField(
            onFieldSubmitted: (_) =>
                ref.read(registerFormProvider.notifier).onFormSubmit(),
            errorMessage: registerForm.isFormPosted
                ? registerForm.email.errorMessage
                : null,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 30),

          CustomTextFormField(
            onFieldSubmitted: (_) =>
                ref.read(registerFormProvider.notifier).onFormSubmit(),
            errorMessage: registerForm.isFormPosted
                ? registerForm.password.errorMessage
                : null,
            onChanged: ref.read(registerFormProvider.notifier).onPasswordChange,
            label: 'Contraseña',
            obscureText: true,
          ),

          const SizedBox(height: 30),

          CustomTextFormField(
            onFieldSubmitted: (_) =>
                ref.read(registerFormProvider.notifier).onFormSubmit(),
            errorMessage: registerForm.isFormPosted
                ? registerForm.confirmPassword.errorMessage
                : null,
            onChanged: ref
                .read(registerFormProvider.notifier)
                .onConfirmPasswordChange,
            label: 'Repita la contraseña',
            obscureText: true,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Crear',
              buttonColor: Colors.black,
              onPressed: registerForm.isPosting
                  ? null
                  : ref.read(registerFormProvider.notifier).onFormSubmit,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    return context.pop();
                  }
                  context.go('/login');
                },
                child: const Text('Ingresa aquí'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
