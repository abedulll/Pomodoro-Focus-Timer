import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen.dart';
import 'constants.dart';
import 'theme_manager.dart';

// ===========================================
// FUNGSI UTAMA (ENTRY POINT)
// ===========================================
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: const PomodoroApp(),
    ),
  );
}

// ===========================================
// POMODORO APP (MATERIAL APP WRAPPER)
// ===========================================
class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      title: 'Aplikasi Pomodoro',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,

      // Tampilan yang pertama kali dimuat
      home: const LoginScreen(),

      // Rute bernama
      routes: {'/pomodoro': (context) => const PomodoroScreen()},
    );
  }
}

// ===========================================
// LOGIN SCREEN / DASHBOARD
// ===========================================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Pomodoro'),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.timer, size: 90, color: primaryRed),
              const SizedBox(height: 30),
              Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigasi ke PomodoroScreen dan menghapus LoginScreen dari stack
                  Navigator.pushReplacementNamed(context, '/pomodoro');
                },
                icon: const Icon(Icons.arrow_forward_ios, size: 20),
                label: const Text(
                  'Mulai Sesi Fokus',
                  style: TextStyle(fontSize: 22),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
