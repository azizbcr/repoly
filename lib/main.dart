import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: MaterialApp(
        title: 'RePolymer',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/home': (context) => const HomeScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
