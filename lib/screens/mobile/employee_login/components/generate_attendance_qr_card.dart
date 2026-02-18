import 'package:flutter/material.dart';

class GenerateAttendanceQrCard extends StatelessWidget {
  final VoidCallback onGenerate;

  const GenerateAttendanceQrCard({super.key, required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Attendance QR'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onGenerate,
              child: const Text('Generate QR'),
            ),
          ],
        ),
      ),
    );
  }
}