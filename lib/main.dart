import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_pos/config/app_router.dart';
import 'package:flux_pos/config/constants/environment.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Environment.initEnvironment();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true, textTheme: GoogleFonts.poppinsTextTheme()),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
