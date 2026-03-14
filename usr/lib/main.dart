import 'package:flutter/material.dart';
import 'screens/main_nav_screen.dart';

void main() {
  runApp(const CouldAITradingApp());
}

class CouldAITradingApp extends StatelessWidget {
  const CouldAITradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CFD Trading App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFF6C90E), // Gold/Yellow accent
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF6C90E),
          surface: Color(0xFF1E1E1E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainNavScreen(),
      },
    );
  }
}
