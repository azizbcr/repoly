import '../models/polymer.dart';

class PolymersDatabase {
  static final List<Polymer> polymers = [
    Polymer(
      name: 'Polipropilen',
      abbreviation: 'PP',
      category: 'Termoplastik',
      description: 'Yaygın kullanılan yarı kristal bir termoplastik polimer.',
      properties: {
        'Yoğunluk': '0.90-0.91 g/cm³',
        'Erime Sıcaklığı': '160-170°C',
        'Çekme Mukavemeti': '30-40 MPa',
      },
      applications: [
        'Ambalaj',
        'Otomotiv parçaları',
        'Ev eşyaları',
      ],
      tensileStrength: 35,
      elongation: 150,
      flexuralModulus: 1.5,
      impactStrength: 4,
      hardness: 75,
      meltingTemp: 165,
      glassTransitionTemp: -10,
      heatDeflection: 105,
      meltFlowIndex: 12,
      isFlameRetardant: false,
      density: 0.905,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '35 MPa',
        'Kopma Uzaması': '150%',
        'Eğilme Modülü': '1.5 GPa',
      },
    ),
    // Diğer polimerler...
  ];
}
