import 'package:flutter/material.dart';
import '../models/polymer.dart';

class PolymerDetailScreen extends StatelessWidget {
  final Polymer polymer;

  const PolymerDetailScreen({super.key, required this.polymer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(polymer.name),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.blueGrey.shade900],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kısaltma: ${polymer.abbreviation}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                'Açıklama: ${polymer.description}',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Text(
                'Erime Sıcaklığı: ${polymer.meltingTemp}°C',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Camsı Geçiş Sıcaklığı: ${polymer.glassTransitionTemp}°C',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'MFI: ${polymer.meltFlowIndex} g/10min',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
