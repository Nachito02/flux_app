import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/providers/auth_provider.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [Text('Bienvenido ${user!.name} ${user.lastName}')],
      ),
    );
  }
}
