import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_pos/features/auth/presentation/providers/providers.dart';
import 'package:flux_pos/features/shared/shared.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(LucideIcons.scanLine)),
          IconButton(onPressed: () {}, icon: Icon(LucideIcons.search)),
        ],
      ),
      body: UserInfo(),
    );
  }
}
