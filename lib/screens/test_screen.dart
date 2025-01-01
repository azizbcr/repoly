import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<TestProcedure> _allTests = [
    // Mekanik Testler
    TestProcedure(
      name: 'Çekme Testi',
      isoCode: 'ISO 527',
      category: 'Mekanik',
      description:
          'Malzemenin çekme mukavemeti, elastik modülü ve uzama değerlerinin belirlenmesi.',
      procedure: [
        'Numune hazırlama (ISO 527-2)',
        'Test hızı: 50mm/dk',
        'Sıcaklık: 23 ±2°C',
        'Nem: 50 ±5%',
      ],
      equipment: ['Universal test cihazı', 'Ekstansometre'],
      results: [
        'Çekme mukavemeti (MPa)',
        'Elastik modül (GPa)',
        'Kopma uzaması (%)'
      ],
    ),
    TestProcedure(
      name: 'Darbe Testi',
      isoCode: 'ISO 179',
      category: 'Mekanik',
      description: 'Charpy darbe dayanımının ölçülmesi.',
      procedure: [
        'Numune hazırlama',
        'Çentikli/çentiksiz test',
        'Standart test koşulları',
      ],
      equipment: ['Charpy darbe test cihazı', 'Çentik açma cihazı'],
      results: ['Darbe dayanımı (kJ/m²)'],
    ),
    TestProcedure(
      name: 'Sertlik Testi',
      isoCode: 'ISO 868',
      category: 'Mekanik',
      description: 'Shore A/D sertlik değerinin ölçülmesi.',
      procedure: [
        'Minimum 6mm kalınlık',
        'En az 5 farklı noktadan ölçüm',
        'Yük uygulama süresi: 15s',
      ],
      equipment: ['Shore durometre'],
      results: ['Shore A/D sertlik değeri'],
    ),

    // Termal Testler
    TestProcedure(
      name: 'DSC Analizi',
      isoCode: 'ISO 11357',
      category: 'Termal',
      description: 'Erime sıcaklığı ve camsı geçiş sıcaklığının belirlenmesi.',
      procedure: [
        'Numune ağırlığı: 5-10mg',
        'Isıtma hızı: 10°C/dk',
        'Sıcaklık aralığı: -50 ile 300°C',
      ],
      equipment: ['DSC cihazı', 'Hassas terazi'],
      results: ['Tm (°C)', 'Tg (°C)', 'Kristallenme derecesi (%)'],
    ),
    TestProcedure(
      name: 'TGA Analizi',
      isoCode: 'ISO 11358',
      category: 'Termal',
      description: 'Termal bozunma ve kararlılık analizi.',
      procedure: [
        'Numune ağırlığı: 10-20mg',
        'Isıtma hızı: 10°C/dk',
        'Atmosfer: N2 veya hava',
      ],
      equipment: ['TGA cihazı'],
      results: ['Bozunma sıcaklığı (°C)', 'Kütle kaybı (%)'],
    ),

    // Reolojik Testler
    TestProcedure(
      name: 'MFI Testi',
      isoCode: 'ISO 1133',
      category: 'Reolojik',
      description: 'Eriyik akış indeksinin ölçülmesi.',
      procedure: [
        'Test sıcaklığı: Malzemeye özgü',
        'Yük: 2.16 kg veya 5 kg',
        'Ölçüm süresi: 10 dakika',
      ],
      equipment: ['MFI test cihazı'],
      results: ['MFI (g/10min)'],
    ),

    // Optik Testler
    TestProcedure(
      name: 'Renk ve Opaklık',
      isoCode: 'ISO 11664',
      category: 'Optik',
      description: 'Renk koordinatları ve opaklık ölçümü.',
      procedure: [
        'Standart aydınlatma koşulları',
        'Minimum 3 ölçüm',
        'Referans beyaz plaka ile kalibrasyon',
      ],
      equipment: ['Spektrofotometre'],
      results: ['L*a*b* değerleri', 'Opaklık (%)'],
    ),
  ];

  List<TestProcedure> get _filteredTests {
    if (_searchQuery.isEmpty) return _allTests;
    return _allTests.where((test) {
      return test.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          test.isoCode.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          test.category.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.blueGrey.shade900],
          ),
        ),
        child: Column(
          children: [
            // Arama Çubuğu
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Test ara...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.tealAccent.shade700),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.tealAccent.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.tealAccent.shade400),
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey.shade800,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            // Test Listesi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _filteredTests.length,
                itemBuilder: (context, index) {
                  final test = _filteredTests[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    color: Colors.blueGrey.shade700,
                    child: ExpansionTile(
                      leading: _getCategoryIcon(test.category),
                      title: Text(
                        test.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${test.category} - ${test.isoCode}',
                        style: TextStyle(color: Colors.tealAccent.shade100),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test.description,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 16),
                              _buildSection('Test Prosedürü:', test.procedure),
                              _buildSection('Gerekli Ekipman:', test.equipment),
                              _buildSection('Sonuçlar:', test.results),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              children: [
                const Icon(Icons.arrow_right, color: Colors.white70, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child:
                      Text(item, style: const TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _getCategoryIcon(String category) {
    IconData iconData;
    Color iconColor;

    switch (category.toLowerCase()) {
      case 'mekanik':
        iconData = Icons.build;
        iconColor = Colors.orange;
        break;
      case 'termal':
        iconData = Icons.thermostat;
        iconColor = Colors.red;
        break;
      case 'reolojik':
        iconData = Icons.water;
        iconColor = Colors.blue;
        break;
      case 'optik':
        iconData = Icons.remove_red_eye;
        iconColor = Colors.purple;
        break;
      default:
        iconData = Icons.science;
        iconColor = Colors.tealAccent;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.2),
      child: Icon(iconData, color: iconColor),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class TestProcedure {
  final String name;
  final String isoCode;
  final String category;
  final String description;
  final List<String> procedure;
  final List<String> equipment;
  final List<String> results;

  TestProcedure({
    required this.name,
    required this.isoCode,
    required this.category,
    required this.description,
    required this.procedure,
    required this.equipment,
    required this.results,
  });
}
