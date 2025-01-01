import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'test_detail_screen.dart';
import '../screens/home_screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Test Prosedürleri'),
          backgroundColor: AppColors.surface,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.background, AppColors.black],
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children:
                allTests.map((test) => _buildTestCard(context, test)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTestCard(BuildContext context, TestProcedure test) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.surface,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _buildCategoryIcon(test.category),
        title: Text(
          test.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          test.description,
          style: const TextStyle(color: Colors.white70),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: _buildCategoryChip(test.category),
        onTap: () => _showTestDetails(context, test),
      ),
    );
  }

  Widget _buildCategoryIcon(TestCategory category) {
    IconData icon;
    Color color;

    switch (category) {
      case TestCategory.mechanical:
        icon = Icons.build;
        color = Colors.blue;
        break;
      case TestCategory.thermal:
        icon = Icons.whatshot;
        color = Colors.orange;
        break;
      case TestCategory.rheological:
        icon = Icons.waves;
        color = Colors.purple;
        break;
      case TestCategory.aging:
        icon = Icons.access_time;
        color = Colors.amber;
        break;
      case TestCategory.flammability:
        icon = Icons.local_fire_department;
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }

  Widget _buildCategoryChip(TestCategory category) {
    String label;
    Color color;

    switch (category) {
      case TestCategory.mechanical:
        label = 'Mekanik';
        color = Colors.blue;
        break;
      case TestCategory.thermal:
        label = 'Termal';
        color = Colors.orange;
        break;
      case TestCategory.rheological:
        label = 'Reolojik';
        color = Colors.purple;
        break;
      case TestCategory.aging:
        label = 'Yaşlandırma';
        color = Colors.amber;
        break;
      case TestCategory.flammability:
        label = 'Yanma';
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showTestDetails(BuildContext context, TestProcedure test) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestDetailScreen(test: test),
      ),
    );
  }
}

enum TestCategory {
  mechanical,
  thermal,
  rheological,
  aging,
  flammability,
}

class TestProcedure {
  final String name;
  final String description;
  final String standard;
  final List<String> parameters;
  final List<String> equipment;
  final TestCategory category;

  TestProcedure({
    required this.name,
    required this.description,
    required this.standard,
    required this.parameters,
    required this.equipment,
    required this.category,
  });
}

final allTests = [
  // MEKANİK TESTLER
  TestProcedure(
    name: 'Çekme Testi',
    description:
        'Malzemenin çekme mukavemeti ve uzama özelliklerinin belirlenmesi.',
    standard: 'ISO 527 / ASTM D638',
    parameters: [
      'Çekme Hızı: 50mm/dk',
      'Numune Tipi: Tip 1A',
      'Test Sıcaklığı: 23°C'
    ],
    equipment: ['Universal Test Cihazı', 'Ekstensometre'],
    category: TestCategory.mechanical,
  ),
  TestProcedure(
    name: 'Darbe Testi',
    description: 'Malzemenin darbe dayanımının ölçülmesi.',
    standard: 'ISO 179 / ASTM D256',
    parameters: [
      'Çentik Tipi: A',
      'Sarkaç Enerjisi: 4J',
      'Test Sıcaklığı: 23°C'
    ],
    equipment: ['Charpy/Izod Darbe Test Cihazı', 'Çentik Açma Cihazı'],
    category: TestCategory.mechanical,
  ),
  TestProcedure(
    name: 'Eğilme Testi',
    description: 'Malzemenin eğilme mukavemeti ve modülünün belirlenmesi.',
    standard: 'ISO 178 / ASTM D790',
    parameters: [
      'Eğilme Hızı: 2mm/dk',
      'Destek Aralığı: 64mm',
      'Test Sıcaklığı: 23°C'
    ],
    equipment: ['Universal Test Cihazı', 'Üç Nokta Eğme Aparatı'],
    category: TestCategory.mechanical,
  ),
  TestProcedure(
    name: 'Sertlik Testi',
    description: 'Malzemenin yüzey sertliğinin ölçülmesi.',
    standard: 'ISO 868 / ASTM D2240',
    parameters: ['Yük: 5kg', 'Bekleme Süresi: 15s', 'Test Sıcaklığı: 23°C'],
    equipment: ['Shore Sertlik Ölçer (A/D)', 'Kalibrasyon Blokları'],
    category: TestCategory.mechanical,
  ),

  // TERMAL TESTLER
  TestProcedure(
    name: 'DSC Analizi',
    description:
        'Erime, kristallenme ve camsı geçiş sıcaklıklarının belirlenmesi.',
    standard: 'ISO 11357 / ASTM D3418',
    parameters: [
      'Isıtma Hızı: 10°C/dk',
      'Sıcaklık Aralığı: -50 ile 300°C',
      'Atmosfer: N2'
    ],
    equipment: ['DSC Cihazı', 'Alüminyum Panlar'],
    category: TestCategory.thermal,
  ),
  TestProcedure(
    name: 'TGA Analizi',
    description: 'Termal bozunma ve dolgu miktarının belirlenmesi.',
    standard: 'ISO 11358 / ASTM E1131',
    parameters: [
      'Isıtma Hızı: 20°C/dk',
      'Sıcaklık Aralığı: 30-800°C',
      'Atmosfer: N2/Hava'
    ],
    equipment: ['TGA Cihazı', 'Seramik Krozeler'],
    category: TestCategory.thermal,
  ),
  TestProcedure(
    name: 'HDT/Vicat Testi',
    description: 'Isı sapma sıcaklığı ve yumuşama noktasının belirlenmesi.',
    standard: 'ISO 75 / ASTM D648',
    parameters: ['Yük: 1.8MPa', 'Isıtma Hızı: 120°C/s', 'Ortam: Yağ Banyosu'],
    equipment: ['HDT/Vicat Test Cihazı', 'Sıcaklık Sensörleri'],
    category: TestCategory.thermal,
  ),

  // REOLOJİK TESTLER
  TestProcedure(
    name: 'MFI Testi',
    description: 'Eriyik akış indeksinin ölçülmesi.',
    standard: 'ISO 1133 / ASTM D1238',
    parameters: ['Yük: 2.16kg', 'Sıcaklık: Polimere Özgü', 'Ölçüm Süresi: 10s'],
    equipment: ['MFI Test Cihazı', 'Kalibrasyon Ağırlıkları'],
    category: TestCategory.rheological,
  ),
  TestProcedure(
    name: 'Kapiler Reometre',
    description: 'Viskozite ve kayma davranışının analizi.',
    standard: 'ISO 11443 / ASTM D3835',
    parameters: ['Kayma Hızı: 100-10000 1/s', 'Sıcaklık: Polimere Özgü'],
    equipment: ['Kapiler Reometre', 'Farklı L/D Oranında Kalıplar'],
    category: TestCategory.rheological,
  ),

  // YAŞLANDIRMA TESTLERİ
  TestProcedure(
    name: 'UV Yaşlandırma',
    description: 'UV ışınlarına karşı dayanımın belirlenmesi.',
    standard: 'ISO 4892 / ASTM G154',
    parameters: [
      'Işın Şiddeti: 0.89 W/m²',
      'Dalga Boyu: 340nm',
      'Süre: 1000 saat'
    ],
    equipment: ['UV Test Kabini', 'Işın Ölçer'],
    category: TestCategory.aging,
  ),
  TestProcedure(
    name: 'Termal Yaşlandırma',
    description: 'Yüksek sıcaklıkta uzun süreli dayanımın testi.',
    standard: 'ISO 188 / ASTM D573',
    parameters: ['Sıcaklık: 125°C', 'Süre: 168 saat', 'Ortam: Hava'],
    equipment: ['Yaşlandırma Fırını', 'Sıcaklık Kontrol Sistemi'],
    category: TestCategory.aging,
  ),

  // YANMA TESTLERİ
  TestProcedure(
    name: 'UL94 Yanma Testi',
    description: 'Malzemenin yanma davranışının sınıflandırılması.',
    standard: 'UL94 / ISO 9772',
    parameters: [
      'Alev Yüksekliği: 20mm',
      'Alev Uygulama Süresi: 10s',
      'Test Sayısı: 5'
    ],
    equipment: ['UL94 Test Düzeneği', 'Kronometre'],
    category: TestCategory.flammability,
  ),
  TestProcedure(
    name: 'LOI Testi',
    description: 'Limit oksijen indeksinin belirlenmesi.',
    standard: 'ISO 4589 / ASTM D2863',
    parameters: ['O2/N2 Karışımı', 'Numune Boyutu: 80x10x4mm'],
    equipment: ['LOI Test Cihazı', 'Gaz Karışım Sistemi'],
    category: TestCategory.flammability,
  ),
];
