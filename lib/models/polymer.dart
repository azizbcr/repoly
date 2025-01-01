import 'package:flutter/material.dart';

class Polymer {
  final String name;
  final String abbreviation;
  final String category;
  final Map<String, dynamic> properties;
  final List<String> applications;
  final String description;
  bool isFavorite;

  // Mekanik Özellikler
  final double tensileStrength;
  final double elongation;
  final double flexuralModulus;
  final double impactStrength;
  final double hardness;

  // Termal Özellikler
  final double meltingTemp;
  final double glassTransitionTemp;
  final double heatDeflection;
  final double meltFlowIndex;

  // Fiziksel Özellikler
  final double density;
  final bool isTransparent;
  final bool isFlexible;

  // Kimyasal Özellikler
  final bool isChemicalResistant;
  final bool isUVResistant;
  final bool isWaterResistant;

  // Özel Özellikler
  final bool isFoodGrade;
  final bool isRecyclable;
  final bool isAntistatic;
  final bool isFlameRetardant;

  // Ek özellikler
  final Map<String, String> additionalProperties;

  // Radar chart için özellikler
  final Color color;
  final double mechanicalStrength;
  final double heatResistance;
  final double chemicalResistance;
  final double processability;
  final double costIndex;

  Polymer({
    required this.name,
    required this.abbreviation,
    required this.category,
    required this.properties,
    required this.applications,
    required this.description,
    this.isFavorite = false,
    required this.tensileStrength,
    required this.elongation,
    required this.flexuralModulus,
    required this.impactStrength,
    required this.hardness,
    required this.meltingTemp,
    required this.glassTransitionTemp,
    required this.heatDeflection,
    required this.meltFlowIndex,
    required this.density,
    required this.isTransparent,
    required this.isFlexible,
    required this.isChemicalResistant,
    required this.isUVResistant,
    required this.isWaterResistant,
    required this.isFoodGrade,
    required this.isRecyclable,
    required this.isAntistatic,
    required this.isFlameRetardant,
    required this.additionalProperties,
    required this.color,
    required this.mechanicalStrength,
    required this.heatResistance,
    required this.chemicalResistance,
    required this.processability,
    required this.costIndex,
  });

  // Özellik kontrolü metodu
  bool hasProperty(String property) {
    switch (property) {
      case 'Yüksek Çekme Dayanımı':
        return tensileStrength > 50;
      case 'Yüksek Darbe Dayanımı':
        return impactStrength > 10;
      case 'Yüksek Sertlik':
        return hardness > 70;
      case 'Esnek':
        return isFlexible;
      case 'Rijit':
        return !isFlexible;
      case 'Yüksek Isı Dayanımı':
        return heatDeflection > 100;
      case 'Düşük Isı Dayanımı':
        return heatDeflection < 100;
      case 'Asit Direnci':
      case 'Baz Direnci':
      case 'Yağ Direnci':
      case 'Solvent Direnci':
        return isChemicalResistant;
      case 'UV Direnci':
        return isUVResistant;
      case 'Su Direnci':
        return isWaterResistant;
      case 'Düşük Yoğunluk':
        return density < 1.0;
      case 'Yüksek Şeffaflık':
        return isTransparent;
      case 'Alev Geciktirici':
        return isFlameRetardant;
      case 'Antistatik':
        return isAntistatic;
      case 'Gıdaya Uygun':
        return isFoodGrade;
      case 'Geri Dönüştürülebilir':
        return isRecyclable;
      default:
        return false;
    }
  }
}
