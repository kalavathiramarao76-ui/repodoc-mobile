import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const RepoDocApp());
}

class RepoDocApp extends StatelessWidget {
  const RepoDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepoDoc',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFF10B981),
        scaffoldBackgroundColor: const Color(0xFF0A0F0D),
        fontFamily: 'monospace',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1410),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF34D399),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            fontFamily: 'monospace',
          ),
          iconTheme: IconThemeData(color: Color(0xFF34D399)),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF111A15),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF0D1410),
          indicatorColor: const Color(0xFF10B981).withOpacity(0.2),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'monospace'),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.black,
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF111A15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1A2F22)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1A2F22)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF10B981), width: 2),
          ),
          hintStyle: TextStyle(color: Colors.grey[600], fontFamily: 'monospace'),
          prefixIconColor: const Color(0xFF34D399),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontFamily: 'monospace'),
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'monospace'),
          bodyLarge: TextStyle(color: Color(0xFFA7C4B5), fontFamily: 'monospace'),
          bodyMedium: TextStyle(color: Color(0xFF7A9B8A), fontFamily: 'monospace'),
        ),
        dividerColor: const Color(0xFF1A2F22),
      ),
      home: const SplashScreen(),
    );
  }
}
