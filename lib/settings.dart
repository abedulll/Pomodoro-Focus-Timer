import 'package:flutter/material.dart';
import 'constants.dart';

class SettingsScreen extends StatefulWidget {
  final int initialWork;
  final int initialShortBreak;
  final int initialLongBreak;

  const SettingsScreen({
    super.key,
    required this.initialWork,
    required this.initialShortBreak,
    required this.initialLongBreak,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late int workTime;
  late int shortBreakTime;
  late int longBreakTime;

  @override
  void initState() {
    super.initState();
    workTime = widget.initialWork ~/ 60;
    shortBreakTime = widget.initialShortBreak ~/ 60;
    longBreakTime = widget.initialLongBreak ~/ 60;
  }

  Widget _buildTimeSetter(
    String label,
    int currentValue,
    Function(int) onValueChange,
  ) {
    const Color primaryColor = primaryIndigo;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle, color: primaryColor),
                iconSize: 30,
                onPressed: () {
                  if (currentValue > 1) {
                    onValueChange(currentValue - 1);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '$currentValue min',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: primaryColor),
                iconSize: 30,
                onPressed: () => onValueChange(currentValue + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Waktu'),
        backgroundColor: primaryIndigo,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Sesuaikan durasi setiap fase (dalam menit):',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            _buildTimeSetter('Waktu Fokus:', workTime, (newValue) {
              setState(() => workTime = newValue);
            }),
            const Divider(),
            _buildTimeSetter('Istirahat Pendek:', shortBreakTime, (newValue) {
              setState(() => shortBreakTime = newValue);
            }),
            const Divider(),
            _buildTimeSetter('Istirahat Panjang:', longBreakTime, (newValue) {
              setState(() => longBreakTime = newValue);
            }),

            const SizedBox(height: 50),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'work': workTime * 60,
                  'shortBreak': shortBreakTime * 60,
                  'longBreak': longBreakTime * 60,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryIndigo,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Simpan Pengaturan',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
