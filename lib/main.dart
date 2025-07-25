import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:tugas_kelompok_dpm/providers/settings_provider.dart';
import 'package:tugas_kelompok_dpm/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const baseTextTheme = TextTheme(
      headlineSmall: TextStyle(
        fontFamily: 'Bree Serif',
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),

      titleMedium: TextStyle(fontFamily: 'Bree Serif', fontSize: 12),

      bodyMedium: TextStyle(fontFamily: 'AR One Sans', fontSize: 12),

      bodySmall: TextStyle(fontFamily: 'Bree Serif', fontSize: 12),

      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

      bodyLarge: TextStyle(fontSize: 16, height: 1.5),
    );

    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return MaterialApp(
          title: 'MikirLUK News',
          themeMode: settingsProvider.themeMode,

          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 1,
            ),
            cardColor: Colors.white,
            useMaterial3: true,

            textTheme: baseTextTheme.apply(
              fontSizeFactor: settingsProvider.fontScale,
              bodyColor: Colors.black87,
              displayColor: Colors.black,
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF224699),
              secondary: Color(0xFF6380EA),
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1F1F1F),
              foregroundColor: Colors.white,
              elevation: 1,
            ),
            cardColor: const Color(0xFF1E1E1E),
            useMaterial3: true,

            textTheme: baseTextTheme.apply(
              fontSizeFactor: settingsProvider.fontScale,
              bodyColor: Colors.white70,
              displayColor: Colors.white,
            ),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8AB4F8),
              secondary: Color(0xFF6380EA),
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
          ),

          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
