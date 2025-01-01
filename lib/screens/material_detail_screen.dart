import 'package:flutter/material.dart';
import '../models/polymer.dart';
import '../theme/app_colors.dart';

class MaterialDetailScreen extends StatelessWidget {
  final Polymer polymer;

  const MaterialDetailScreen({
    super.key,
    required this.polymer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(polymer.name),
        backgroundColor: AppColors.surface,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.black],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildProperties(),
              _buildApplications(),
              _buildMechanicalProperties(),
              _buildThermalProperties(),
              _buildAdditionalProperties(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              polymer.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              polymer.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProperties() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Temel Özellikler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...polymer.properties.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplications() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Uygulama Alanları',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...polymer.applications.map(
              (app) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_right, color: Colors.tealAccent),
                    const SizedBox(width: 8),
                    Text(
                      app,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicalProperties() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mekanik Özellikler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPropertyRow(
                'Çekme Mukavemeti', '${polymer.tensileStrength} MPa'),
            _buildPropertyRow('Kopma Uzaması', '${polymer.elongation}%'),
            _buildPropertyRow(
                'Eğilme Modülü', '${polymer.flexuralModulus} GPa'),
            _buildPropertyRow(
                'Darbe Dayanımı', '${polymer.impactStrength} kJ/m²'),
            _buildPropertyRow('Sertlik', '${polymer.hardness} Shore D'),
          ],
        ),
      ),
    );
  }

  Widget _buildThermalProperties() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Termal Özellikler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPropertyRow('Erime Sıcaklığı', '${polymer.meltingTemp}°C'),
            _buildPropertyRow(
                'Camsı Geçiş Sıcaklığı', '${polymer.glassTransitionTemp}°C'),
            _buildPropertyRow(
                'Isı Sapma Sıcaklığı', '${polymer.heatDeflection}°C'),
            _buildPropertyRow(
                'Erime Akış İndeksi', '${polymer.meltFlowIndex} g/10min'),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalProperties() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ek Özellikler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...polymer.additionalProperties.entries.map(
              (entry) => _buildPropertyRow(entry.key, entry.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
