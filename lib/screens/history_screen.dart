import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Colors.blueGrey.shade900,
          ],
        ),
      ),
      child: const Center(
        child: Text(
          'Geçmiş',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
