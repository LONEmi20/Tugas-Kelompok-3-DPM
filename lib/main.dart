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
    // [FIX] Mendefinisikan TextTheme dasar agar ukuran font konsisten
    const baseTextTheme = TextTheme(
      // Untuk judul berita di Hero Card
      headlineSmall: TextStyle(fontFamily: 'Bree Serif', fontWeight: FontWeight.w400, fontSize: 20),
      // Untuk judul berita di list biasa
      titleMedium: TextStyle(fontFamily: 'Bree Serif', fontSize: 12),
      // Untuk isi berita di Hero Card
      bodyMedium: TextStyle(fontFamily: 'AR One Sans', fontSize: 12),
      // Untuk teks kecil seperti tanggal
      bodySmall: TextStyle(fontFamily: 'Bree Serif', fontSize: 12),
      // Untuk judul di halaman detail
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      // Untuk isi di halaman detail
      bodyLarge: TextStyle(fontSize: 16, height: 1.5),
    );

    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return MaterialApp(
          title: 'MikirLUK News',
          themeMode: settingsProvider.themeMode,
          
          // Definisi tema untuk mode terang (Light Mode)
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
            // [FIX] Menggunakan TextTheme dasar dan menerapkan skala font
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
          
          // Definisi tema untuk mode gelap (Dark Mode)
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
            // [FIX] Menggunakan TextTheme dasar dan menerapkan skala font
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
