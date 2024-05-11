import 'package:flutter/material.dart';
import 'package:frontend/components/components.dart';
import 'package:frontend/screens/screens.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authService),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SludHealtech',
      initialRoute: 'splash',
      routes: {
        '/': (_) => const HomeScreen(),
        'splash': (_) => const SplashScreen(),
        'login': (_) => const LoginScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Color.fromARGB(255, 21, 45, 86),
        ),
      ),
    );
  }
}
