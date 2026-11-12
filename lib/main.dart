import 'package:flutter/material.dart';

import 'config/app_config.dart';
import 'providers/app_provider.dart';
import 'screens/home_screen.dart';

/// Titik masuk aplikasi.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();
  runApp(const MyApp());
}

/// Root widget dengan tema terpusat.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    appBarTheme: const AppBarTheme(centerTitle: true),
  );

  @override
  Widget build(BuildContext context) => AppProviderWrapper(
        child: MaterialApp(
          title: 'Profil Mahasiswa',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const HomeScreen(),
        ),
      );
}
