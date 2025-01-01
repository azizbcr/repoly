import 'package:flutter/material.dart';
import '../models/polymer.dart';
import 'package:fl_chart/fl_chart.dart';

class ComparisonScreen extends StatelessWidget {
  final List<Polymer> selectedPolymers;

  const ComparisonScreen({super.key, required this.selectedPolymers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polimer Karşılaştırma'),
        backgroundColor: Colors.black,
      ),
      body: Container(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Başlık Kartları
              Row(
                children: [
                  Expanded(child: _buildPolymerCard(selectedPolymers[0])),
                  const SizedBox(width: 16),
                  Expanded(child: _buildPolymerCard(selectedPolymers[1])),
                ],
              ),
              const SizedBox(height: 24),

              // Özellik Karşılaştırma Tablosu
              Card(
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildComparisonRow(
                        'Erime Sıcaklığı',
                        '${selectedPolymers[0].meltingTemp}°C',
                        '${selectedPolymers[1].meltingTemp}°C',
                        showDifference: true,
                      ),
                      _buildComparisonRow(
                        'Camsı Geçiş',
                        '${selectedPolymers[0].glassTransitionTemp}°C',
                        '${selectedPolymers[1].glassTransitionTemp}°C',
                        showDifference: true,
                      ),
                      _buildComparisonRow(
                        'MFI',
                        '${selectedPolymers[0].meltFlowIndex} g/10min',
                        '${selectedPolymers[1].meltFlowIndex} g/10min',
                        showDifference: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Mekanik Özellikler
              Card(
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      for (var property
                          in selectedPolymers[0].additionalProperties.keys)
                        _buildComparisonRow(
                          property,
                          selectedPolymers[0].additionalProperties[property]!,
                          selectedPolymers[1].additionalProperties[property]!,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Kullanım Alanları ve Öneriler
              Card(
                color: Colors.blueGrey.shade800,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Öneriler',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildRecommendation(
                          selectedPolymers[0], selectedPolymers[1]),
                    ],
                  ),
                ),
              ),

              // Özellik Karşılaştırma Grafiği
              Card(
                color: Colors.blueGrey.shade800,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Özellik Karşılaştırma Grafiği',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 300,
                        child: RadarChart(
                          RadarChartData(
                            radarShape: RadarShape.polygon,
                            ticksTextStyle:
                                const TextStyle(color: Colors.transparent),
                            gridBorderData:
                                BorderSide(color: Colors.white24, width: 1),
                            titleTextStyle: const TextStyle(
                                color: Colors.white60, fontSize: 12),
                            getTitle: (index, angle) {
                              String title;
                              switch (index) {
                                case 0:
                                  title = 'Erime\nSıcaklığı';
                                  break;
                                case 1:
                                  title = 'İşlenebilirlik';
                                  break;
                                case 2:
                                  title = 'Mekanik\nMukavemet';
                                  break;
                                case 3:
                                  title = 'Kimyasal\nDirenç';
                                  break;
                                case 4:
                                  title = 'Maliyet\nUygunluğu';
                                  break;
                                default:
                                  title = '';
                              }
                              return RadarChartTitle(
                                text: title,
                                angle: angle,
                              );
                            },
                            dataSets: [
                              RadarDataSet(
                                fillColor: Colors.tealAccent.withOpacity(0.1),
                                borderColor: Colors.tealAccent,
                                entryRadius: 3,
                                dataEntries: [
                                  RadarEntry(
                                      value: _normalizeValue(
                                          selectedPolymers[0].meltingTemp,
                                          300)),
                                  RadarEntry(
                                      value: _normalizeValue(
                                          selectedPolymers[0].meltFlowIndex,
                                          30)),
                                  RadarEntry(
                                      value: _getMechanicalScore(
                                          selectedPolymers[0])),
                                  RadarEntry(
                                      value: _getChemicalScore(
                                          selectedPolymers[0])),
                                  RadarEntry(
                                      value:
                                          _getCostScore(selectedPolymers[0])),
                                ],
                              ),
                              RadarDataSet(
                                fillColor: Colors.orangeAccent.withOpacity(0.1),
                                borderColor: Colors.orangeAccent,
                                entryRadius: 3,
                                dataEntries: [
                                  RadarEntry(
                                      value: _normalizeValue(
                                          selectedPolymers[1].meltingTemp,
                                          300)),
                                  RadarEntry(
                                      value: _normalizeValue(
                                          selectedPolymers[1].meltFlowIndex,
                                          30)),
                                  RadarEntry(
                                      value: _getMechanicalScore(
                                          selectedPolymers[1])),
                                  RadarEntry(
                                      value: _getChemicalScore(
                                          selectedPolymers[1])),
                                  RadarEntry(
                                      value:
                                          _getCostScore(selectedPolymers[1])),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Grafik Açıklaması
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegendItem(selectedPolymers[0].abbreviation,
                              Colors.tealAccent),
                          const SizedBox(width: 24),
                          _buildLegendItem(selectedPolymers[1].abbreviation,
                              Colors.orangeAccent),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolymerCard(Polymer polymer) {
    return Card(
      color: Colors.blueGrey.shade700,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.tealAccent.shade700,
              radius: 30,
              child: Text(
                polymer.abbreviation,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              polymer.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonRow(String property, String value1, String value2,
      {bool showDifference = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              property,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          Expanded(
            child: Text(
              value1,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              value2,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation(Polymer polymer1, Polymer polymer2) {
    // Basit bir karşılaştırma algoritması
    String recommendation = '';

    // Erime sıcaklığı karşılaştırması
    if (polymer1.meltingTemp > polymer2.meltingTemp) {
      recommendation +=
          '• ${polymer1.name} daha yüksek sıcaklık dayanımına sahiptir.\n';
    } else if (polymer1.meltingTemp < polymer2.meltingTemp) {
      recommendation +=
          '• ${polymer2.name} daha yüksek sıcaklık dayanımına sahiptir.\n';
    }

    // MFI karşılaştırması
    if (polymer1.meltFlowIndex > polymer2.meltFlowIndex) {
      recommendation += '• ${polymer1.name} daha kolay işlenebilir.\n';
    } else if (polymer1.meltFlowIndex < polymer2.meltFlowIndex) {
      recommendation += '• ${polymer2.name} daha kolay işlenebilir.\n';
    }

    // Mekanik özellik karşılaştırması
    if (polymer1.additionalProperties.containsKey('Çekme Mukavemeti') &&
        polymer2.additionalProperties.containsKey('Çekme Mukavemeti')) {
      final strength1 = double.tryParse(polymer1
              .additionalProperties['Çekme Mukavemeti']!
              .split(' ')[0]) ??
          0;
      final strength2 = double.tryParse(polymer2
              .additionalProperties['Çekme Mukavemeti']!
              .split(' ')[0]) ??
          0;

      if (strength1 > strength2) {
        recommendation +=
            '• ${polymer1.name} daha yüksek mekanik mukavemete sahiptir.\n';
      } else if (strength1 < strength2) {
        recommendation +=
            '• ${polymer2.name} daha yüksek mekanik mukavemete sahiptir.\n';
      }
    }

    // Genel kullanım önerisi
    recommendation += '\nÖneriler:\n';
    if (polymer1.meltingTemp > 200) {
      recommendation +=
          '• ${polymer1.name} yüksek sıcaklık uygulamaları için uygundur.\n';
    }
    if (polymer2.meltingTemp > 200) {
      recommendation +=
          '• ${polymer2.name} yüksek sıcaklık uygulamaları için uygundur.\n';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        recommendation,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  double _normalizeValue(double value, double max) => (value / max).clamp(0, 1);

  double _getMechanicalScore(Polymer polymer) {
    if (!polymer.additionalProperties.containsKey('Çekme Mukavemeti'))
      return 0.5;
    final strength = double.tryParse(
            polymer.additionalProperties['Çekme Mukavemeti']!.split(' ')[0]) ??
        0;
    return _normalizeValue(strength, 100);
  }

  double _getChemicalScore(Polymer polymer) {
    // Polimere göre kimyasal direnç puanı
    switch (polymer.abbreviation) {
      case 'PP':
        return 0.8;
      case 'PE':
        return 0.7;
      case 'PVC':
        return 0.6;
      case 'PS':
        return 0.4;
      case 'PET':
        return 0.75;
      default:
        return 0.5;
    }
  }

  double _getCostScore(Polymer polymer) {
    // Polimere göre maliyet uygunluğu puanı (1 = en ekonomik)
    switch (polymer.abbreviation) {
      case 'PP':
        return 0.9;
      case 'PE':
        return 0.95;
      case 'PVC':
        return 0.85;
      case 'PS':
        return 0.8;
      case 'PET':
        return 0.75;
      default:
        return 0.5;
    }
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
