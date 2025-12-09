import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'settings.dart';
import 'theme_manager.dart';
import 'constants.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  // Variabel Konfigurasi Waktu
  int _workDuration = 25 * 60;
  int _shortBreakDuration = 5 * 60;
  int _longBreakDuration = 15 * 60;
  static const int _pomodorosBeforeLongBreak = 4;

  // Variabel State Timer
  int _waktuSekarang = 25 * 60;
  int _pomodoroCount = 0;
  String _statusTeks = "FOKUS";
  Color _warnaFase = primaryRed;

  Timer? _timer;
  bool _isRunning = false;

  // NOTIFIKASI SUARA
  final AudioPlayer _notificationPlayer = AudioPlayer();
  final String _notificationSoundPath = 'sounds/bell.mp3';

  @override
  void initState() {
    super.initState();
    _resetTimer();
    _notificationPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _notificationPlayer.dispose();
    super.dispose();
  }

  void _playNotificationSound() async {
    await _notificationPlayer.play(AssetSource(_notificationSoundPath));
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_waktuSekarang > 0) {
          _waktuSekarang--;

          if (_waktuSekarang == 5) {
            _playNotificationSound();
          }
        } else {
          timer.cancel();
          _isRunning = false;
          _changePhase();
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _waktuSekarang = _workDuration;
      _statusTeks = "FOKUS";
      _warnaFase = primaryRed;
      _pomodoroCount = 0;
    });
  }

  void _changePhase() {
    int newDuration;
    String newStatus;
    Color newColor;

    if (_statusTeks == "FOKUS") {
      _pomodoroCount++;

      if (_pomodoroCount % _pomodorosBeforeLongBreak == 0) {
        newStatus = "ISTIRAHAT PANJANG";
        newDuration = _longBreakDuration;
        newColor = Colors.green;
      } else {
        newStatus = "ISTIRAHAT PENDEK";
        newDuration = _shortBreakDuration;
        newColor = Colors.blueAccent;
      }
    } else {
      newStatus = "FOKUS";
      newDuration = _workDuration;
      newColor = primaryRed;
    }

    setState(() {
      _statusTeks = newStatus;
      _warnaFase = newColor;
      _waktuSekarang = newDuration;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fase baru: $newStatus dimulai.'),
        backgroundColor: newColor,
        duration: const Duration(seconds: 2),
      ),
    );
    _startTimer();
  }

  String _formatTime(int totalDetik) {
    final int menit = totalDetik ~/ 60;
    final int detik = totalDetik % 60;
    return '${menit.toString().padLeft(2, '0')}:${detik.toString().padLeft(2, '0')}';
  }

  void _navigateToSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          initialWork: _workDuration,
          initialShortBreak: _shortBreakDuration,
          initialLongBreak: _longBreakDuration,
        ),
      ),
    );

    if (result != null && result is Map<String, int>) {
      setState(() {
        _workDuration = result['work']!;
        _shortBreakDuration = result['shortBreak']!;
        _longBreakDuration = result['longBreak']!;
      });
      _resetTimer();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengaturan Waktu Diperbarui.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.themeMode == ThemeMode.dark;

    final scaffoldBgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        centerTitle: true,
        backgroundColor: _warnaFase,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: themeManager.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: _navigateToSettings,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _statusTeks,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: _warnaFase,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Sesi Selesai: $_pomodoroCount',
              style: TextStyle(fontSize: 18, color: textColor.withOpacity(0.6)),
            ),

            const SizedBox(height: 50),

            // TIMER LINGKARAN (UI Modern)
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: scaffoldBgColor,
                shape: BoxShape.circle,
                border: Border.all(color: _warnaFase, width: 6),
                boxShadow: [
                  BoxShadow(
                    color: _warnaFase.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 3,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _formatTime(_waktuSekarang),
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w200,
                    color: _warnaFase,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),

            // Tombol Kontrol
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  icon: Icon(
                    _isRunning ? Icons.pause : Icons.play_arrow,
                    size: 28,
                  ),
                  label: Text(
                    _isRunning ? 'JEDA' : 'MULAI',
                    style: const TextStyle(fontSize: 22),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _warnaFase,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                ),

                const SizedBox(width: 20),

                OutlinedButton(
                  onPressed: _resetTimer,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 20,
                    ),
                    side: BorderSide(color: _warnaFase, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 20, color: _warnaFase),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
