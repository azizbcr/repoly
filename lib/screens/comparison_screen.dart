import 'package:flutter/material.dart';
import '../models/polymer.dart';
import '../theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';

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
      child: Column(
        children: [
          Row(
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
          const SizedBox(height: 24),
          _buildRadarChart(),
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

  Widget _buildRadarChart() {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: RadarChart(
            RadarChartData(
              radarShape: RadarShape.polygon,
              ticksTextStyle:
                  const TextStyle(color: Colors.white70, fontSize: 12),
              gridBorderData: BorderSide(color: Colors.white24, width: 1),
              tickBorderData: BorderSide(color: Colors.white24, width: 1),
              getTitle: (index, angle) {
                switch (index) {
                  case 0:
                    return RadarChartTitle(
                      text: 'Mekanik Dayanım',
                      angle: angle,
                    );
                  case 1:
                    return RadarChartTitle(
                      text: 'Isı Dayanımı',
                      angle: angle,
                    );
                  case 2:
                    return RadarChartTitle(
                      text: 'Kimyasal Direnç',
                      angle: angle,
                    );
                  case 3:
                    return RadarChartTitle(
                      text: 'İşlenebilirlik',
                      angle: angle,
                    );
                  case 4:
                    return RadarChartTitle(
                      text: 'Maliyet',
                      angle: angle,
                    );
                  default:
                    return const RadarChartTitle(text: '');
                }
              },
              dataSets: [
                RadarDataSet(
                  fillColor: selectedPolymers[0].color.withOpacity(0.2),
                  borderColor: selectedPolymers[0].color,
                  entryRadius: 3,
                  dataEntries: [
                    RadarEntry(value: selectedPolymers[0].mechanicalStrength),
                    RadarEntry(value: selectedPolymers[0].heatResistance),
                    RadarEntry(value: selectedPolymers[0].chemicalResistance),
                    RadarEntry(value: selectedPolymers[0].processability),
                    RadarEntry(value: selectedPolymers[0].costIndex),
                  ],
                ),
                RadarDataSet(
                  fillColor: selectedPolymers[1].color.withOpacity(0.2),
                  borderColor: selectedPolymers[1].color,
                  entryRadius: 3,
                  dataEntries: [
                    RadarEntry(value: selectedPolymers[1].mechanicalStrength),
                    RadarEntry(value: selectedPolymers[1].heatResistance),
                    RadarEntry(value: selectedPolymers[1].chemicalResistance),
                    RadarEntry(value: selectedPolymers[1].processability),
                    RadarEntry(value: selectedPolymers[1].costIndex),
                  ],
                ),
              ],
              titleTextStyle: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              tickCount: 5,
              titlePositionPercentageOffset: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildChartLegend(),
      ],
    );
  }

  Widget _buildChartLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem(
            selectedPolymers[0].name,
            selectedPolymers[0].color,
          ),
          const SizedBox(width: 24),
          _buildLegendItem(
            selectedPolymers[1].name,
            selectedPolymers[1].color,
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            border: Border.all(color: color),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class ComparisonItem {
  final String property;
  final String value1;
  final String value2;

  ComparisonItem(this.property, this.value1, this.value2);
}
