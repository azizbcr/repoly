import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/polymers_database.dart';
import '../models/polymer.dart';
import 'filter_results_screen.dart';

class MaterialSelectorScreen extends StatefulWidget {
  const MaterialSelectorScreen({super.key});

  @override
  State<MaterialSelectorScreen> createState() => _MaterialSelectorScreenState();
}

class _MaterialSelectorScreenState extends State<MaterialSelectorScreen> {
  String? _selectedRequirement;

  final Map<String, bool> _filters = {
    // Mekanik Özellikler
    'Yüksek Çekme Dayanımı': false,
    'Yüksek Darbe Dayanımı': false,
    'Yüksek Sertlik': false,
    'Yüksek Yorulma Direnci': false,
    'Yüksek Aşınma Direnci': false,
    'Esnek': false,
    'Rijit': false,

    // Termal Özellikler
    'Yüksek Isı Dayanımı': false,
    'Düşük Isı Dayanımı': false,
    'Isı İzolasyonu': false,
    'Boyutsal Kararlılık': false,

    // Kimyasal Özellikler
    'Asit Direnci': false,
    'Baz Direnci': false,
    'Yağ Direnci': false,
    'Solvent Direnci': false,
    'UV Direnci': false,
    'Su Direnci': false,

    // Fiziksel Özellikler
    'Düşük Yoğunluk': false,
    'Yüksek Şeffaflık': false,
    'Mat Görünüm': false,
    'Pürüzsüz Yüzey': false,

    // Özel Özellikler
    'Alev Geciktirici': false,
    'Antistatik': false,
    'Gıdaya Uygun': false,
    'Geri Dönüştürülebilir': false,
    'Biyobozunur': false,
    'Sterilize Edilebilir': false,
    'Elektrik İzolasyonu': false,
    'Elektrik İletkenliği': false,
  };

  // Özellikleri kategorilere ayıralım
  final Map<String, List<String>> _filterCategories = {
    'Mekanik Özellikler': [
      'Yüksek Çekme Dayanımı',
      'Yüksek Darbe Dayanımı',
      'Yüksek Sertlik',
      'Yüksek Yorulma Direnci',
      'Yüksek Aşınma Direnci',
      'Esnek',
      'Rijit',
    ],
    'Termal Özellikler': [
      'Yüksek Isı Dayanımı',
      'Düşük Isı Dayanımı',
      'Isı İzolasyonu',
      'Boyutsal Kararlılık',
    ],
    'Kimyasal Özellikler': [
      'Asit Direnci',
      'Baz Direnci',
      'Yağ Direnci',
      'Solvent Direnci',
      'UV Direnci',
      'Su Direnci',
    ],
    'Fiziksel Özellikler': [
      'Düşük Yoğunluk',
      'Yüksek Şeffaflık',
      'Mat Görünüm',
      'Pürüzsüz Yüzey',
    ],
    'Özel Özellikler': [
      'Alev Geciktirici',
      'Antistatik',
      'Gıdaya Uygun',
      'Geri Dönüştürülebilir',
      'Biyobozunur',
      'Sterilize Edilebilir',
      'Elektrik İzolasyonu',
      'Elektrik İletkenliği',
    ],
  };

  final Map<String, String> _requirements = {
    'mekanik': 'Yüksek Mekanik Dayanım',
    'termal': 'Yüksek Sıcaklık Dayanımı',
    'kimyasal': 'Kimyasal Direnç',
    'optik': 'Optik Şeffaflık',
    'elektrik': 'Elektriksel Özellikler',
    'darbe': 'Darbe Dayanımı',
    'aşınma': 'Aşınma Direnci',
  };

  final List<Polymer> _filteredPolymers = [];

  void _searchPolymers() {
    setState(() {
      _filteredPolymers.clear();

      // Seçili özelliklere sahip polimerleri filtrele
      for (var polymer in PolymersDatabase.polymers) {
        bool matchesAllFilters = true;

        // Seçili filtreleri kontrol et
        for (var entry in _filters.entries) {
          if (entry.value && !polymer.hasProperty(entry.key)) {
            matchesAllFilters = false;
            break;
          }
        }

        // Ana gereksinim kontrolü
        if (_selectedRequirement != null) {
          switch (_selectedRequirement) {
            case 'mekanik':
              if (polymer.tensileStrength < 40) matchesAllFilters = false;
              break;
            case 'termal':
              if (polymer.heatDeflection < 100) matchesAllFilters = false;
              break;
            // Diğer gereksinimler...
          }
        }

        if (matchesAllFilters) {
          _filteredPolymers.add(polymer);
        }
      }
    });

    // Sonuçları göster
    if (_filteredPolymers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seçili kriterlere uygun malzeme bulunamadı.'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FilterResultsScreen(polymers: _filteredPolymers),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Malzeme Seçici'),
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
              // Başlık
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Uygulamanıza Göre Malzeme Seçin',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gereksinimleri belirtin ve size uygun malzemeleri bulalım',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Ana Gereksinim Seçici
              Padding(
                padding: const EdgeInsets.all(16),
                child: DropdownButtonFormField<String>(
                  value: _selectedRequirement,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Ana gereksinimi seçin',
                    hintStyle: TextStyle(color: AppColors.grey),
                  ),
                  dropdownColor: AppColors.surface,
                  style: const TextStyle(color: AppColors.white),
                  items: _requirements.entries.map((entry) {
                    return DropdownMenuItem(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedRequirement = value;
                    });
                  },
                ),
              ),

              // Özellik Filtreleri
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'İstenen Özellikler',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._filterCategories.entries.map((category) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.key,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: category.value.map((property) {
                              return FilterChip(
                                label: Text(property),
                                selected: _filters[property] ?? false,
                                onSelected: (bool selected) {
                                  setState(() {
                                    _filters[property] = selected;
                                  });
                                },
                                selectedColor:
                                    AppColors.primary.withOpacity(0.2),
                                checkmarkColor: AppColors.primary,
                                labelStyle: TextStyle(
                                  color: _filters[property] == true
                                      ? AppColors.primary
                                      : AppColors.grey,
                                ),
                                backgroundColor: AppColors.surface,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Malzeme Ara Butonu
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _searchPolymers();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'MALZEME ARA',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
