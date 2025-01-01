import 'package:flutter/material.dart';
import '../models/polymer.dart';
import '../theme/app_colors.dart';

class ComparisonScreen extends StatelessWidget {
  final List<Polymer> selectedPolymers;

  const ComparisonScreen({
    super.key,
    required this.selectedPolymers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polimer Karşılaştırma'),
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
              _buildComparisonHeader(),
              _buildMechanicalProperties(),
              _buildThermalProperties(),
              _buildPhysicalProperties(),
              _buildChemicalProperties(),
              _buildApplications(),
              _buildAdditionalProperties(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildPolymerCard(selectedPolymers[0]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildPolymerCard(selectedPolymers[1]),
          ),
        ],
      ),
    );
  }

  Widget _buildPolymerCard(Polymer polymer) {
    return Card(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              polymer.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              polymer.abbreviation,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              polymer.category,
              style: TextStyle(
                color: Colors.tealAccent.shade200,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicalProperties() {
    return _buildComparisonSection(
      'Mekanik Özellikler',
      [
        ComparisonItem(
          'Çekme Mukavemeti',
          '${selectedPolymers[0].tensileStrength} MPa',
          '${selectedPolymers[1].tensileStrength} MPa',
        ),
        ComparisonItem(
          'Kopma Uzaması',
          '${selectedPolymers[0].elongation}%',
          '${selectedPolymers[1].elongation}%',
        ),
        ComparisonItem(
          'Eğilme Modülü',
          '${selectedPolymers[0].flexuralModulus} GPa',
          '${selectedPolymers[1].flexuralModulus} GPa',
        ),
        ComparisonItem(
          'Darbe Dayanımı',
          '${selectedPolymers[0].impactStrength} kJ/m²',
          '${selectedPolymers[1].impactStrength} kJ/m²',
        ),
        ComparisonItem(
          'Sertlik',
          '${selectedPolymers[0].hardness} Shore D',
          '${selectedPolymers[1].hardness} Shore D',
        ),
      ],
    );
  }

  Widget _buildThermalProperties() {
    return _buildComparisonSection(
      'Termal Özellikler',
      [
        ComparisonItem(
          'Erime Sıcaklığı',
          '${selectedPolymers[0].meltingTemp}°C',
          '${selectedPolymers[1].meltingTemp}°C',
        ),
        ComparisonItem(
          'Camsı Geçiş Sıcaklığı',
          '${selectedPolymers[0].glassTransitionTemp}°C',
          '${selectedPolymers[1].glassTransitionTemp}°C',
        ),
        ComparisonItem(
          'Isı Sapma Sıcaklığı',
          '${selectedPolymers[0].heatDeflection}°C',
          '${selectedPolymers[1].heatDeflection}°C',
        ),
        ComparisonItem(
          'Erime Akış İndeksi',
          '${selectedPolymers[0].meltFlowIndex} g/10min',
          '${selectedPolymers[1].meltFlowIndex} g/10min',
        ),
      ],
    );
  }

  Widget _buildPhysicalProperties() {
    return _buildComparisonSection(
      'Fiziksel Özellikler',
      [
        ComparisonItem(
          'Yoğunluk',
          '${selectedPolymers[0].density} g/cm³',
          '${selectedPolymers[1].density} g/cm³',
        ),
        ComparisonItem(
          'Şeffaflık',
          selectedPolymers[0].isTransparent ? 'Evet' : 'Hayır',
          selectedPolymers[1].isTransparent ? 'Evet' : 'Hayır',
        ),
        ComparisonItem(
          'Esneklik',
          selectedPolymers[0].isFlexible ? 'Esnek' : 'Rijit',
          selectedPolymers[1].isFlexible ? 'Esnek' : 'Rijit',
        ),
      ],
    );
  }

  Widget _buildChemicalProperties() {
    return _buildComparisonSection(
      'Kimyasal Özellikler',
      [
        ComparisonItem(
          'Kimyasal Direnç',
          selectedPolymers[0].isChemicalResistant ? 'İyi' : 'Zayıf',
          selectedPolymers[1].isChemicalResistant ? 'İyi' : 'Zayıf',
        ),
        ComparisonItem(
          'UV Direnci',
          selectedPolymers[0].isUVResistant ? 'İyi' : 'Zayıf',
          selectedPolymers[1].isUVResistant ? 'İyi' : 'Zayıf',
        ),
        ComparisonItem(
          'Su Direnci',
          selectedPolymers[0].isWaterResistant ? 'İyi' : 'Zayıf',
          selectedPolymers[1].isWaterResistant ? 'İyi' : 'Zayıf',
        ),
      ],
    );
  }

  Widget _buildApplications() {
    return _buildComparisonSection(
      'Uygulama Alanları',
      [
        ComparisonItem(
          'Uygulamalar',
          selectedPolymers[0].applications.join('\n'),
          selectedPolymers[1].applications.join('\n'),
        ),
      ],
    );
  }

  Widget _buildAdditionalProperties() {
    final properties1 = selectedPolymers[0].additionalProperties;
    final properties2 = selectedPolymers[1].additionalProperties;

    return _buildComparisonSection(
      'Ek Özellikler',
      properties1.keys.map((key) {
        return ComparisonItem(
          key,
          properties1[key] ?? '-',
          properties2[key] ?? '-',
        );
      }).toList(),
    );
  }

  Widget _buildComparisonSection(String title, List<ComparisonItem> items) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: AppColors.surface.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(color: Colors.white24),
          ...items.map((item) => _buildComparisonRow(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(ComparisonItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              item.property,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          Expanded(
            child: Text(
              item.value1,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              item.value2,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ComparisonItem {
  final String property;
  final String value1;
  final String value2;

  ComparisonItem(this.property, this.value1, this.value2);
}
