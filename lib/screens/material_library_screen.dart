import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/polymer.dart';
import '../screens/settings_screen.dart';
import '../screens/polymer_detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/test_screen.dart';
import '../screens/history_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/comparison_screen.dart';
import '../providers/favorites_provider.dart';
import '../screens/material_detail_screen.dart';
import '../screens/splash_screen.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_bottom_nav.dart';
import '../screens/material_selector_screen.dart';

class MaterialLibraryScreen extends StatefulWidget {
  const MaterialLibraryScreen({super.key});

  @override
  State<MaterialLibraryScreen> createState() => _MaterialLibraryScreenState();
}

class _MaterialLibraryScreenState extends State<MaterialLibraryScreen> {
  String _searchQuery = '';
  int _selectedIndex = 1;
  List<Polymer> _comparisonList = [];

  static final List<Polymer> _allPolymers = [
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
      applications: ['Ambalaj', 'Otomotiv parçaları', 'Ev eşyaları'],
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
    Polymer(
      name: 'Polietilen',
      abbreviation: 'PE',
      category: 'Termoplastik',
      description: 'En yaygın kullanılan termoplastik polimer.',
      properties: {
        'Yoğunluk': '0.91-0.97 g/cm³',
        'Erime Sıcaklığı': '120-140°C',
        'Çekme Mukavemeti': '20-30 MPa',
      },
      applications: ['Ambalaj', 'Borular', 'Film'],
      tensileStrength: 25,
      elongation: 400,
      flexuralModulus: 1.0,
      impactStrength: 6,
      hardness: 65,
      meltingTemp: 130,
      glassTransitionTemp: -120,
      heatDeflection: 85,
      meltFlowIndex: 8,
      isFlameRetardant: false,
      density: 0.94,
      isTransparent: false,
      isFlexible: true,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '25 MPa',
        'Kopma Uzaması': '400%',
        'Eğilme Modülü': '1.0 GPa',
      },
    ),
    Polymer(
      name: 'Polistiren',
      abbreviation: 'PS',
      category: 'Termoplastik',
      description:
          'Sert ve kırılgan bir termoplastik. Şeffaf ve kolay işlenebilir.',
      properties: {
        'Yoğunluk': '1.04-1.06 g/cm³',
        'Erime Sıcaklığı': '220-260°C',
        'Çekme Mukavemeti': '35-50 MPa',
      },
      applications: ['Ambalaj', 'Elektronik', 'Oyuncak'],
      tensileStrength: 45,
      elongation: 3,
      flexuralModulus: 3.0,
      impactStrength: 2,
      hardness: 85,
      meltingTemp: 240,
      glassTransitionTemp: 100,
      heatDeflection: 95,
      meltFlowIndex: 10,
      isFlameRetardant: false,
      density: 1.05,
      isTransparent: true,
      isFlexible: false,
      isChemicalResistant: false,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '45 MPa',
        'Kopma Uzaması': '3%',
        'Eğilme Modülü': '3.0 GPa',
      },
    ),
    Polymer(
      name: 'Polivinil Klorür',
      abbreviation: 'PVC',
      category: 'Termoplastik',
      description:
          'Dayanıklı ve ekonomik bir polimer. Yapı malzemelerinde yaygın kullanılır.',
      properties: {
        'Yoğunluk': '1.3-1.45 g/cm³',
        'Erime Sıcaklığı': '190-210°C',
        'Çekme Mukavemeti': '40-60 MPa',
      },
      applications: ['Yapı Malzemeleri', 'Borular', 'Profiller'],
      tensileStrength: 50,
      elongation: 80,
      flexuralModulus: 2.8,
      impactStrength: 5,
      hardness: 80,
      meltingTemp: 200,
      glassTransitionTemp: 85,
      heatDeflection: 75,
      meltFlowIndex: 15,
      isFlameRetardant: true,
      density: 1.4,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: false,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '50 MPa',
        'Kopma Uzaması': '80%',
        'Eğilme Modülü': '2.8 GPa',
      },
    ),
    Polymer(
      name: 'Polietilen Tereftalat',
      abbreviation: 'PET',
      category: 'Termoplastik',
      description: 'İçecek şişelerinde yaygın kullanılan şeffaf polimer.',
      properties: {
        'Yoğunluk': '1.37 g/cm³',
        'Erime Sıcaklığı': '250-270°C',
        'Çekme Mukavemeti': '55-75 MPa',
      },
      applications: ['İçecek Şişeleri', 'Ambalaj', 'Tekstil Elyafı'],
      tensileStrength: 65,
      elongation: 70,
      flexuralModulus: 2.6,
      impactStrength: 3,
      hardness: 85,
      meltingTemp: 260,
      glassTransitionTemp: 70,
      heatDeflection: 80,
      meltFlowIndex: 20,
      isFlameRetardant: false,
      density: 1.37,
      isTransparent: true,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '65 MPa',
        'Kopma Uzaması': '70%',
        'Eğilme Modülü': '2.6 GPa',
      },
    ),
    Polymer(
      name: 'Poliamid (Naylon)',
      abbreviation: 'PA',
      category: 'Termoplastik',
      description:
          'Yüksek mekanik dayanım ve aşınma direncine sahip mühendislik plastiği.',
      properties: {
        'Yoğunluk': '1.13-1.15 g/cm³',
        'Erime Sıcaklığı': '220-265°C',
        'Çekme Mukavemeti': '70-85 MPa',
      },
      applications: ['Dişli', 'Rulman', 'Tekstil'],
      tensileStrength: 80,
      elongation: 60,
      flexuralModulus: 2.8,
      impactStrength: 7,
      hardness: 82,
      meltingTemp: 245,
      glassTransitionTemp: 50,
      heatDeflection: 95,
      meltFlowIndex: 25,
      isFlameRetardant: false,
      density: 1.14,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: false,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '80 MPa',
        'Kopma Uzaması': '60%',
        'Eğilme Modülü': '2.8 GPa',
      },
    ),
    Polymer(
      name: 'Polikarbonat',
      abbreviation: 'PC',
      category: 'Termoplastik',
      description:
          'Yüksek darbe dayanımı ve optik şeffaflığa sahip mühendislik plastiği.',
      properties: {
        'Yoğunluk': '1.20 g/cm³',
        'Erime Sıcaklığı': '280-300°C',
        'Çekme Mukavemeti': '60-70 MPa',
      },
      applications: ['CD/DVD', 'Gözlük Camı', 'Koruyucu Ekipman'],
      tensileStrength: 65,
      elongation: 100,
      flexuralModulus: 2.3,
      impactStrength: 15,
      hardness: 78,
      meltingTemp: 290,
      glassTransitionTemp: 147,
      heatDeflection: 130,
      meltFlowIndex: 18,
      isFlameRetardant: true,
      density: 1.20,
      isTransparent: true,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '65 MPa',
        'Kopma Uzaması': '100%',
        'Eğilme Modülü': '2.3 GPa',
      },
    ),
    Polymer(
      name: 'Akrilonitril Bütadien Stiren',
      abbreviation: 'ABS',
      category: 'Termoplastik',
      description:
          'Darbe dayanımı yüksek, kolay işlenebilen ve iyi yüzey kalitesi sunan polimer.',
      properties: {
        'Yoğunluk': '1.05 g/cm³',
        'Erime Sıcaklığı': '220-240°C',
        'Çekme Mukavemeti': '40-50 MPa',
      },
      applications: ['Otomotiv Parçaları', 'Elektronik Kasalar', 'Oyuncak'],
      tensileStrength: 45,
      elongation: 30,
      flexuralModulus: 2.4,
      impactStrength: 20,
      hardness: 76,
      meltingTemp: 230,
      glassTransitionTemp: 105,
      heatDeflection: 98,
      meltFlowIndex: 22,
      isFlameRetardant: true,
      density: 1.05,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: false,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '45 MPa',
        'Kopma Uzaması': '30%',
        'Eğilme Modülü': '2.4 GPa',
      },
    ),
    Polymer(
      name: 'Polimetil Metakrilat',
      abbreviation: 'PMMA',
      category: 'Termoplastik',
      description:
          'Yüksek optik şeffaflığa sahip, UV dayanımlı ve sert bir polimer.',
      properties: {
        'Yoğunluk': '1.18 g/cm³',
        'Erime Sıcaklığı': '160-200°C',
        'Çekme Mukavemeti': '70-80 MPa',
      },
      applications: ['Cam Alternatifi', 'Aydınlatma', 'Reklam Panoları'],
      tensileStrength: 75,
      elongation: 5,
      flexuralModulus: 3.2,
      impactStrength: 2,
      hardness: 90,
      meltingTemp: 180,
      glassTransitionTemp: 105,
      heatDeflection: 95,
      meltFlowIndex: 14,
      isFlameRetardant: false,
      density: 1.18,
      isTransparent: true,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Çekme Mukavemeti': '75 MPa',
        'Kopma Uzaması': '5%',
        'Eğilme Modülü': '3.2 GPa',
      },
    ),
    Polymer(
      name: 'Polietereterketon',
      abbreviation: 'PEEK',
      category: 'Yüksek Performans',
      description:
          'Yüksek sıcaklık ve kimyasal direnci olan ileri mühendislik termoplastiği.',
      properties: {
        'Yoğunluk': '1.32 g/cm³',
        'Erime Sıcaklığı': '340-350°C',
        'Çekme Mukavemeti': '90-100 MPa',
      },
      applications: ['Havacılık', 'Medikal', 'Otomotiv'],
      tensileStrength: 95,
      elongation: 45,
      flexuralModulus: 3.8,
      impactStrength: 7.5,
      hardness: 85,
      meltingTemp: 343,
      glassTransitionTemp: 143,
      heatDeflection: 160,
      meltFlowIndex: 3,
      isFlameRetardant: true,
      density: 1.32,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Maksimum Kullanım Sıcaklığı': '260°C',
        'Kimyasal Direnç': 'Mükemmel',
        'Radyasyon Direnci': 'İyi',
      },
    ),
    Polymer(
      name: 'Polibütilen Tereftalat',
      abbreviation: 'PBT',
      category: 'Mühendislik Plastiği',
      description:
          'Yüksek kristallenme hızına sahip, boyutsal kararlı mühendislik termoplastiği.',
      properties: {
        'Yoğunluk': '1.31 g/cm³',
        'Erime Sıcaklığı': '220-230°C',
        'Çekme Mukavemeti': '50-60 MPa',
      },
      applications: ['Elektrik/Elektronik', 'Otomotiv', 'Endüstriyel'],
      tensileStrength: 55,
      elongation: 250,
      flexuralModulus: 2.6,
      impactStrength: 6,
      hardness: 80,
      meltingTemp: 225,
      glassTransitionTemp: 60,
      heatDeflection: 120,
      meltFlowIndex: 15,
      isFlameRetardant: true,
      density: 1.31,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Elektriksel Özellikler': 'Mükemmel',
        'Boyutsal Kararlılık': 'Çok İyi',
        'İşlenebilirlik': 'İyi',
      },
    ),
    Polymer(
      name: 'Polifenilen Sülfür',
      abbreviation: 'PPS',
      category: 'Yüksek Performans',
      description:
          'Yüksek sıcaklık ve kimyasal direnci olan yarı kristal mühendislik plastiği.',
      properties: {
        'Yoğunluk': '1.35 g/cm³',
        'Erime Sıcaklığı': '280-290°C',
        'Çekme Mukavemeti': '75-85 MPa',
      },
      applications: ['Otomotiv', 'Elektrik/Elektronik', 'Kimya Endüstrisi'],
      tensileStrength: 80,
      elongation: 3,
      flexuralModulus: 3.7,
      impactStrength: 4,
      hardness: 88,
      meltingTemp: 285,
      glassTransitionTemp: 85,
      heatDeflection: 150,
      meltFlowIndex: 20,
      isFlameRetardant: true,
      density: 1.35,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Kimyasal Direnç': 'Mükemmel',
        'Boyutsal Kararlılık': 'Mükemmel',
        'Alev Dayanımı': 'V-0',
      },
    ),
    Polymer(
      name: 'Termoplastik Poliüretan',
      abbreviation: 'TPU',
      category: 'Elastomer',
      description:
          'Esnek, aşınmaya dayanıklı ve geniş sertlik aralığına sahip termoplastik elastomer.',
      properties: {
        'Yoğunluk': '1.12 g/cm³',
        'Erime Sıcaklığı': '180-220°C',
        'Çekme Mukavemeti': '20-50 MPa',
      },
      applications: ['Ayakkabı', 'Spor Ekipmanları', 'Endüstriyel Contalar'],
      tensileStrength: 35,
      elongation: 600,
      flexuralModulus: 0.1,
      impactStrength: 25,
      hardness: 70,
      meltingTemp: 200,
      glassTransitionTemp: -40,
      heatDeflection: 80,
      meltFlowIndex: 12,
      isFlameRetardant: false,
      density: 1.12,
      isTransparent: true,
      isFlexible: true,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Shore Sertliği': '70A-75D',
        'Aşınma Direnci': 'Mükemmel',
        'Yağ Direnci': 'İyi',
      },
    ),
    Polymer(
      name: 'Akrilonitril Stiren Akrilat',
      abbreviation: 'ASA',
      category: 'Termoplastik',
      description:
          'UV dayanımlı, dış mekan kullanımına uygun, ABS alternatifi polimer.',
      properties: {
        'Yoğunluk': '1.07 g/cm³',
        'Erime Sıcaklığı': '220-270°C',
        'Çekme Mukavemeti': '40-50 MPa',
      },
      applications: ['Dış Cephe', 'Otomotiv', 'Bahçe Mobilyası'],
      tensileStrength: 45,
      elongation: 35,
      flexuralModulus: 2.3,
      impactStrength: 15,
      hardness: 82,
      meltingTemp: 245,
      glassTransitionTemp: 100,
      heatDeflection: 95,
      meltFlowIndex: 18,
      isFlameRetardant: true,
      density: 1.07,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: false,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'UV Dayanımı': 'Mükemmel',
        'Renk Kararlılığı': 'Çok İyi',
        'Yüzey Kalitesi': 'Mükemmel',
      },
    ),
    Polymer(
      name: 'Polieterimid',
      abbreviation: 'PEI',
      category: 'Yüksek Performans',
      description:
          'Yüksek sıcaklık dayanımı ve mekanik özelliklere sahip amorf termoplastik.',
      properties: {
        'Yoğunluk': '1.27 g/cm³',
        'Erime Sıcaklığı': '350-400°C',
        'Çekme Mukavemeti': '105-115 MPa',
      },
      applications: ['Havacılık', 'Elektronik', 'Medikal'],
      tensileStrength: 110,
      elongation: 60,
      flexuralModulus: 3.3,
      impactStrength: 5.3,
      hardness: 86,
      meltingTemp: 375,
      glassTransitionTemp: 217,
      heatDeflection: 200,
      meltFlowIndex: 9,
      isFlameRetardant: true,
      density: 1.27,
      isTransparent: true,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Dielektrik Sabiti': '3.15',
        'Sterilizasyon': 'Tüm Metodlar',
        'Yanmazlık': 'V-0',
      },
    ),
    Polymer(
      name: 'Polisülfon',
      abbreviation: 'PSU',
      category: 'Yüksek Performans',
      description:
          'Yüksek sıcaklık ve kimyasal direnci olan şeffaf mühendislik plastiği.',
      properties: {
        'Yoğunluk': '1.24 g/cm³',
        'Erime Sıcaklığı': '310-360°C',
        'Çekme Mukavemeti': '70-75 MPa',
      },
      applications: ['Medikal', 'Membran', 'Elektrik/Elektronik'],
      tensileStrength: 72,
      elongation: 50,
      flexuralModulus: 2.7,
      impactStrength: 6.5,
      hardness: 84,
      meltingTemp: 335,
      glassTransitionTemp: 185,
      heatDeflection: 174,
      meltFlowIndex: 14,
      isFlameRetardant: true,
      density: 1.24,
      isTransparent: true,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Hidroliz Direnci': 'Mükemmel',
        'Gamma Sterilizasyon': 'Uygun',
        'Creep Direnci': 'Çok İyi',
      },
    ),
    Polymer(
      name: 'Polifenilen Oksit',
      abbreviation: 'PPO',
      category: 'Mühendislik Plastiği',
      description:
          'Yüksek sıcaklık dayanımı ve boyutsal kararlılığa sahip amorf polimer.',
      properties: {
        'Yoğunluk': '1.06 g/cm³',
        'Erime Sıcaklığı': '260-280°C',
        'Çekme Mukavemeti': '55-65 MPa',
      },
      applications: ['Otomotiv', 'Elektrik', 'Su Sistemleri'],
      tensileStrength: 60,
      elongation: 40,
      flexuralModulus: 2.4,
      impactStrength: 13,
      hardness: 80,
      meltingTemp: 270,
      glassTransitionTemp: 215,
      heatDeflection: 180,
      meltFlowIndex: 8,
      isFlameRetardant: true,
      density: 1.06,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Boyutsal Kararlılık': 'Mükemmel',
        'Elektriksel Özellikler': 'Çok İyi',
        'Sürünme Direnci': 'İyi',
      },
    ),
    Polymer(
      name: 'Sıvı Kristal Polimer',
      abbreviation: 'LCP',
      category: 'Yüksek Performans',
      description:
          'Yüksek sıcaklık ve kimyasal direnci olan, düşük viskoziteli mühendislik plastiği.',
      properties: {
        'Yoğunluk': '1.4-1.7 g/cm³',
        'Erime Sıcaklığı': '280-330°C',
        'Çekme Mukavemeti': '130-190 MPa',
      },
      applications: [
        'Elektronik Konektörler',
        'Hassas Parçalar',
        'Yüksek Isı Uygulamaları'
      ],
      tensileStrength: 160,
      elongation: 3,
      flexuralModulus: 10.5,
      impactStrength: 6,
      hardness: 88,
      meltingTemp: 300,
      glassTransitionTemp: 125,
      heatDeflection: 260,
      meltFlowIndex: 10,
      isFlameRetardant: true,
      density: 1.6,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Boyutsal Kararlılık': 'Mükemmel',
        'Akış Özellikleri': 'Çok İyi',
        'Elektriksel Özellikler': 'Mükemmel',
      },
    ),
    Polymer(
      name: 'Poliamidimid',
      abbreviation: 'PAI',
      category: 'Yüksek Performans',
      description:
          'En yüksek performanslı termoplastiklerden biri. Mükemmel mekanik ve termal özellikler.',
      properties: {
        'Yoğunluk': '1.42 g/cm³',
        'Erime Sıcaklığı': '370-390°C',
        'Çekme Mukavemeti': '185-200 MPa',
      },
      applications: ['Havacılık', 'Yüksek Sıcaklık Rulmanları', 'Yarı İletken'],
      tensileStrength: 190,
      elongation: 12,
      flexuralModulus: 5.2,
      impactStrength: 4,
      hardness: 95,
      meltingTemp: 380,
      glassTransitionTemp: 275,
      heatDeflection: 280,
      meltFlowIndex: 4,
      isFlameRetardant: true,
      density: 1.42,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Maksimum Kullanım Sıcaklığı': '280°C',
        'Aşınma Direnci': 'Mükemmel',
        'Radyasyon Direnci': 'İyi',
      },
    ),
    Polymer(
      name: 'Polibenzimidazol',
      abbreviation: 'PBI',
      category: 'Yüksek Performans',
      description:
          'En yüksek sıcaklık dayanımına sahip termoplastik. Uzay ve havacılık uygulamaları.',
      properties: {
        'Yoğunluk': '1.3 g/cm³',
        'Erime Sıcaklığı': '760°C',
        'Çekme Mukavemeti': '160 MPa',
      },
      applications: ['Uzay', 'Yakıt Hücreleri', 'Koruyucu Giysiler'],
      tensileStrength: 160,
      elongation: 3,
      flexuralModulus: 5.9,
      impactStrength: 2,
      hardness: 92,
      meltingTemp: 760,
      glassTransitionTemp: 425,
      heatDeflection: 435,
      meltFlowIndex: 1,
      isFlameRetardant: true,
      density: 1.3,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: false,
      isRecyclable: false,
      isAntistatic: false,
      additionalProperties: {
        'Maksimum Kullanım Sıcaklığı': '400°C',
        'Alev Dayanımı': 'Mükemmel',
        'Asit/Baz Direnci': 'Mükemmel',
      },
    ),
    Polymer(
      name: 'Cam Elyaf Takviyeli Polipropilen',
      abbreviation: 'PP-GF30',
      category: 'Kompozit',
      description:
          'Yüksek mukavemet ve rijitliğe sahip, cam elyaf takviyeli mühendislik kompoziti.',
      properties: {
        'Yoğunluk': '1.14 g/cm³',
        'Erime Sıcaklığı': '160-170°C',
        'Çekme Mukavemeti': '85-100 MPa',
      },
      applications: ['Otomotiv', 'Beyaz Eşya', 'Endüstriyel Parçalar'],
      tensileStrength: 90,
      elongation: 3,
      flexuralModulus: 6.5,
      impactStrength: 9,
      hardness: 85,
      meltingTemp: 165,
      glassTransitionTemp: -10,
      heatDeflection: 155,
      meltFlowIndex: 8,
      isFlameRetardant: true,
      density: 1.14,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Cam Elyaf Oranı': '%30',
        'Boyutsal Kararlılık': 'Mükemmel',
        'Yorulma Direnci': 'Çok İyi',
      },
    ),
    Polymer(
      name: 'Karbon Elyaf Takviyeli PEEK',
      abbreviation: 'PEEK-CF30',
      category: 'Yüksek Performans Kompozit',
      description:
          'Ultra yüksek performanslı, karbon elyaf takviyeli havacılık sınıfı polimer.',
      properties: {
        'Yoğunluk': '1.4 g/cm³',
        'Erime Sıcaklığı': '340-350°C',
        'Çekme Mukavemeti': '240-260 MPa',
      },
      applications: ['Havacılık', 'F1', 'Uzay Teknolojileri'],
      tensileStrength: 250,
      elongation: 2,
      flexuralModulus: 22.5,
      impactStrength: 8,
      hardness: 95,
      meltingTemp: 343,
      glassTransitionTemp: 143,
      heatDeflection: 315,
      meltFlowIndex: 1,
      isFlameRetardant: true,
      density: 1.4,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: false,
      isAntistatic: true,
      additionalProperties: {
        'Karbon Elyaf Oranı': '%30',
        'Özgül Mukavemet': 'Mükemmel',
        'FST Özellikleri': 'Havacılık Standardı',
      },
    ),
    Polymer(
      name: 'PC/ABS Alaşımı',
      abbreviation: 'PC/ABS',
      category: 'Polimer Alaşımı',
      description:
          'Polikarbonat ve ABS\'in avantajlarını birleştiren mühendislik termoplastiği alaşımı.',
      properties: {
        'Yoğunluk': '1.12 g/cm³',
        'Erime Sıcaklığı': '220-260°C',
        'Çekme Mukavemeti': '55-65 MPa',
      },
      applications: [
        'Otomotiv İç Parçaları',
        'Elektronik Kasalar',
        'Cihaz Gövdeleri'
      ],
      tensileStrength: 60,
      elongation: 120,
      flexuralModulus: 2.3,
      impactStrength: 45,
      hardness: 82,
      meltingTemp: 230,
      glassTransitionTemp: 125,
      heatDeflection: 115,
      meltFlowIndex: 12,
      isFlameRetardant: true,
      density: 1.12,
      isTransparent: false,
      isFlexible: false,
      isChemicalResistant: true,
      isUVResistant: false,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: false,
      additionalProperties: {
        'Darbe Dayanımı': 'Mükemmel',
        'Yüzey Kalitesi': 'Çok İyi',
        'İşlenebilirlik': 'İyi',
      },
    ),
    Polymer(
      name: 'Poliüretan Elastomer',
      abbreviation: 'TPU-ES',
      category: 'Özel Elastomer',
      description:
          'Yüksek aşınma direnci ve elastikiyete sahip, özel formüle edilmiş termoplastik elastomer.',
      properties: {
        'Yoğunluk': '1.18 g/cm³',
        'Erime Sıcaklığı': '180-220°C',
        'Çekme Mukavemeti': '45-55 MPa',
      },
      applications: [
        'Spor Ayakkabı',
        'Endüstriyel Kaplamalar',
        'Otomotiv Parçaları'
      ],
      tensileStrength: 50,
      elongation: 850,
      flexuralModulus: 0.15,
      impactStrength: 35,
      hardness: 60,
      meltingTemp: 200,
      glassTransitionTemp: -45,
      heatDeflection: 70,
      meltFlowIndex: 15,
      isFlameRetardant: false,
      density: 1.18,
      isTransparent: true,
      isFlexible: true,
      isChemicalResistant: true,
      isUVResistant: true,
      isWaterResistant: true,
      isFoodGrade: true,
      isRecyclable: true,
      isAntistatic: true,
      additionalProperties: {
        'Shore Sertliği': '60D',
        'Aşınma Direnci': 'Üstün',
        'Geri Tepme': 'Mükemmel',
      },
    ),
  ];

  List<Polymer> get _filteredPolymers {
    List<Polymer> filteredList = [];
    if (_searchQuery.isEmpty) {
      filteredList = List.from(_allPolymers);
    } else {
      filteredList = _allPolymers
          .where((polymer) =>
              polymer.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              polymer.abbreviation
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    filteredList.sort((a, b) {
      final favoritesProvider =
          Provider.of<FavoritesProvider>(context, listen: false);
      final aIsFavorite = favoritesProvider.isFavorite(a);
      final bIsFavorite = favoritesProvider.isFavorite(b);

      if (aIsFavorite && !bIsFavorite) {
        return -1;
      } else if (!aIsFavorite && bIsFavorite) {
        return 1;
      }
      return 0;
    });

    return filteredList;
  }

  void _addToComparison(Polymer polymer) {
    if (_comparisonList.length < 2) {
      setState(() {
        _comparisonList.add(polymer);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _comparisonList.length == 1
                ? '${polymer.name} karşılaştırma listesine eklendi. Bir polimer daha seçin.'
                : '${polymer.name} eklendi. Karşılaştırma başlatılıyor...',
          ),
          action: _comparisonList.length == 2
              ? SnackBarAction(
                  label: 'KARŞILAŞTIR',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComparisonScreen(
                          selectedPolymers: _comparisonList,
                        ),
                      ),
                    ).then((_) {
                      setState(() {
                        _comparisonList.clear();
                      });
                    });
                  },
                )
              : null,
        ),
      );

      if (_comparisonList.length == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComparisonScreen(
              selectedPolymers: _comparisonList,
            ),
          ),
        ).then((_) {
          setState(() {
            _comparisonList.clear();
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Malzeme Kütüphanesi'),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
              (route) => false,
            );
          },
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.surface,
                AppColors.background,
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _PolymerSearchDelegate(_allPolymers),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.black],
          ),
        ),
        child: _buildLibraryContent(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 0: // Ana Sayfa
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
              break;

            case 1: // Malzemeler - Zaten buradayız
              break;

            case 2: // Test Et
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: const Text('Test Prosedürleri'),
                      backgroundColor: AppColors.surface,
                    ),
                    body: const TestScreen(),
                  ),
                ),
              );
              break;

            case 3: // Malzeme Seç
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaterialSelectorScreen(),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.shade800.withOpacity(0.5),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.tealAccent.shade400),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildLibraryContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _filteredPolymers.length,
      itemBuilder: (context, index) {
        final polymer = _filteredPolymers[index];
        return Card(
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          elevation: 8,
          color: Colors.blueGrey.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Colors.tealAccent.shade700.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blueGrey.shade700,
                  Colors.blueGrey.shade800,
                ],
              ),
            ),
            child: ListTile(
              title: Text(
                polymer.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                polymer.description,
                style: const TextStyle(color: Colors.white70),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Provider.of<FavoritesProvider>(context)
                              .isFavorite(polymer)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Provider.of<FavoritesProvider>(context)
                              .isFavorite(polymer)
                          ? Colors.redAccent
                          : Colors.white70,
                    ),
                    onPressed: () {
                      final favoritesProvider = Provider.of<FavoritesProvider>(
                          context,
                          listen: false);
                      if (favoritesProvider.isFavorite(polymer)) {
                        favoritesProvider.removeFavorite(polymer);
                      } else {
                        favoritesProvider.addFavorite(polymer);
                      }
                      setState(() {}); // Listeyi yeniden sırala
                    },
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.compare_arrows, color: Colors.white70),
                    onPressed: () => _addToComparison(polymer),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MaterialDetailScreen(polymer: polymer),
                  ),
                );
              },
              onLongPress: () => _addToComparison(
                  polymer), // Uzun basınca karşılaştırmaya ekle
            ),
          ),
        );
      },
    );
  }
}

class _PolymerSearchDelegate extends SearchDelegate<Polymer?> {
  final List<Polymer> polymers;

  _PolymerSearchDelegate(this.polymers);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = polymers.where((polymer) {
      return polymer.name.toLowerCase().contains(query.toLowerCase()) ||
          polymer.abbreviation.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Container(
      color: Colors.blueGrey.shade900,
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final polymer = results[index];
          return ListTile(
            title: Text(
              polymer.name,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              polymer.abbreviation,
              style: const TextStyle(color: Colors.white70),
            ),
            onTap: () {
              close(context, polymer);
            },
          );
        },
      ),
    );
  }
}
