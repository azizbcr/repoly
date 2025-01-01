import 'package:flutter/material.dart';
import '../models/polymer.dart';
import '../screens/material_detail_screen.dart';

class MaterialSelectorScreen extends StatefulWidget {
  const MaterialSelectorScreen({super.key});

  @override
  State<MaterialSelectorScreen> createState() => _MaterialSelectorScreenState();
}

class _MaterialSelectorScreenState extends State<MaterialSelectorScreen> {
  String? _selectedRequirement;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Filtreleme seçenekleri
  final Map<String, bool> _filters = {
    'Ekonomik': false,
    'Yüksek Performans': false,
    'Gıdaya Uygun': false,
    'Geri Dönüştürülebilir': false,
  };

  // Ana gereksinimler
  final List<String> _requirements = [
    'Kimyasallara Dayanıklı Malzeme',
    'Yüksek Sıcaklığa Dayanıklı Malzeme',
    'Darbelere Dayanıklı Malzeme',
    'Şeffaf Malzeme',
    'Gıda ile Temasa Uygun Malzeme',
    'Ekonomik Malzeme',
    'UV Dayanımlı Malzeme',
    'Kolay İşlenebilir Malzeme',
  ];

  // Her gereksinim için öneriler
  final Map<String, List<Map<String, dynamic>>> _recommendations = {
    'Kimyasallara Dayanıklı Malzeme': [
      {
        'name': 'PVC',
        'description': 'Asit, baz ve birçok kimyasala karşı yüksek direnç',
        'rating': 5,
        'details': [
          'Asit ve bazlara karşı mükemmel direnç',
          'Ekonomik fiyat',
          'Kolay işlenebilirlik',
        ],
      },
      {
        'name': 'PTFE',
        'description': 'En yüksek kimyasal dirence sahip polimer',
        'rating': 5,
        'details': [
          'Neredeyse tüm kimyasallara karşı dirençli',
          'Yüksek sıcaklık dayanımı',
          'Düşük sürtünme katsayısı',
        ],
      },
      {
        'name': 'PP',
        'description': 'İyi kimyasal direnç, ekonomik çözüm',
        'rating': 4,
        'details': [
          'Asitlere karşı iyi direnç',
          'Uygun fiyat',
          'Kolay işlenebilirlik',
        ],
      },
    ],
    'Yüksek Sıcaklığa Dayanıklı Malzeme': [
      {
        'name': 'PEEK',
        'description': 'En yüksek sıcaklık dayanımına sahip termoplastik',
        'rating': 5,
        'details': [
          '250°C sürekli çalışma sıcaklığı',
          'Mükemmel mekanik özellikler',
          'Kimyasal direnç',
        ],
      },
      {
        'name': 'PPS',
        'description': 'Yüksek sıcaklık dayanımı ve boyutsal kararlılık',
        'rating': 4,
        'details': [
          '200°C sürekli çalışma sıcaklığı',
          'Mükemmel boyutsal kararlılık',
          'İyi kimyasal direnç',
        ],
      },
      {
        'name': 'PEI',
        'description': 'Yüksek sıcaklık dayanımı ve şeffaflık',
        'rating': 4,
        'details': [
          '170°C sürekli çalışma sıcaklığı',
          'Şeffaflık özelliği',
          'Alev geciktirici',
        ],
      },
    ],
    'Darbelere Dayanıklı Malzeme': [
      {
        'name': 'PC',
        'description': 'Yüksek darbe dayanımı ve şeffaflık',
        'rating': 5,
        'details': [
          'Mükemmel darbe dayanımı',
          'İyi optik özellikler',
          'Geniş sıcaklık aralığı',
        ],
      },
      {
        'name': 'ABS',
        'description': 'İyi darbe dayanımı ve yüzey kalitesi',
        'rating': 4,
        'details': [
          'Yüksek darbe dayanımı',
          'Kolay işlenebilirlik',
          'Ekonomik fiyat',
        ],
      },
      {
        'name': 'HIPS',
        'description': 'Ekonomik darbe dayanımlı polimer',
        'rating': 3,
        'details': [
          'İyi darbe dayanımı',
          'Çok ekonomik',
          'Kolay işlenebilirlik',
        ],
      },
    ],
    'Şeffaf Malzeme': [
      {
        'name': 'PMMA',
        'description': 'En iyi optik özelliklere sahip polimer',
        'rating': 5,
        'details': [
          'Camla karşılaştırılabilir şeffaflık',
          'UV dayanımı',
          'Çizilme direnci',
        ],
      },
      {
        'name': 'PC',
        'description': 'Yüksek darbe dayanımlı şeffaf polimer',
        'rating': 4,
        'details': [
          'İyi optik özellikler',
          'Yüksek darbe dayanımı',
          'Isı dayanımı',
        ],
      },
      {
        'name': 'PET',
        'description': 'Ekonomik şeffaf polimer',
        'rating': 4,
        'details': [
          'İyi şeffaflık',
          'Gıda ile temasa uygun',
          'Geri dönüştürülebilir',
        ],
      },
    ],
    'Gıda ile Temasa Uygun Malzeme': [
      {
        'name': 'PP',
        'description': 'En yaygın kullanılan gıda ambalaj malzemesi',
        'rating': 5,
        'details': [
          'FDA onaylı',
          'Mikrodalga kullanımına uygun',
          'Ekonomik',
        ],
      },
      {
        'name': 'PET',
        'description': 'İçecek şişelerinde standart malzeme',
        'rating': 5,
        'details': [
          'Mükemmel bariyer özellikleri',
          'Şeffaflık',
          'Geri dönüştürülebilir',
        ],
      },
      {
        'name': 'HDPE',
        'description': 'Süt şişeleri ve gıda kapları için ideal',
        'rating': 4,
        'details': [
          'Kimyasal direnç',
          'Sağlam yapı',
          'Ekonomik',
        ],
      },
    ],
    'Ekonomik Malzeme': [
      {
        'name': 'PE',
        'description': 'En ekonomik ve yaygın polimer',
        'rating': 5,
        'details': [
          'Düşük maliyet',
          'Kolay işlenebilirlik',
          'Çok yönlü kullanım',
        ],
      },
      {
        'name': 'PP',
        'description': 'Ekonomik ve çok yönlü',
        'rating': 4,
        'details': [
          'Uygun fiyat',
          'İyi mekanik özellikler',
          'Geniş kullanım alanı',
        ],
      },
      {
        'name': 'PS',
        'description': 'Ekonomik ve rijit yapı',
        'rating': 4,
        'details': [
          'Düşük maliyet',
          'Kolay işlenebilirlik',
          'Rijit yapı',
        ],
      },
    ],
    'UV Dayanımlı Malzeme': [
      {
        'name': 'ASA',
        'description': 'En iyi UV dayanımına sahip polimer',
        'rating': 5,
        'details': [
          'Mükemmel UV dayanımı',
          'Renk kararlılığı',
          'Dış mekan kullanımı',
        ],
      },
      {
        'name': 'PC',
        'description': 'UV katkılı versiyonları mevcut',
        'rating': 4,
        'details': [
          'İyi UV dayanımı',
          'Yüksek darbe dayanımı',
          'Şeffaflık özelliği',
        ],
      },
      {
        'name': 'PMMA',
        'description': 'Doğal UV dayanımı',
        'rating': 4,
        'details': [
          'Doğal UV bariyeri',
          'Mükemmel şeffaflık',
          'Çizilme direnci',
        ],
      },
    ],
    'Kolay İşlenebilir Malzeme': [
      {
        'name': 'PP',
        'description': 'Çok yönlü işlenebilirlik',
        'rating': 5,
        'details': [
          'Geniş işleme penceresi',
          'Düşük çekme oranı',
          'Hızlı üretim döngüsü',
        ],
      },
      {
        'name': 'PE',
        'description': 'Basit işleme koşulları',
        'rating': 5,
        'details': [
          'Kolay kalıplanabilirlik',
          'Düşük işleme sıcaklığı',
          'Az enerji tüketimi',
        ],
      },
      {
        'name': 'PS',
        'description': 'Hızlı ve kolay işleme',
        'rating': 4,
        'details': [
          'İyi akışkanlık',
          'Hızlı soğuma',
          'Düşük kalıp maliyeti',
        ],
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Malzeme Seçim Asistanı'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Container(
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
                  hintText: 'Malzeme ara...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white70),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            // Aktif Filtreler
            if (_filters.values.any((isActive) => isActive))
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: _filters.entries
                      .where((entry) => entry.value)
                      .map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(
                          entry.key,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.tealAccent.shade700,
                        deleteIcon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                        onDeleted: () {
                          setState(() {
                            _filters[entry.key] = false;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

            // Gereksinim Listesi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _getFilteredRequirements().length,
                itemBuilder: (context, index) {
                  final requirement = _getFilteredRequirements()[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    color: Colors.blueGrey.shade800,
                    child: ListTile(
                      title: Text(
                        requirement,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 16,
                      ),
                      onTap: () {
                        setState(() {
                          _selectedRequirement = requirement;
                        });
                        _showRecommendations(requirement);
                      },
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

  List<String> _getFilteredRequirements() {
    return _requirements.where((requirement) {
      final matchesSearch =
          requirement.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      if (_filters.values.every((isActive) => !isActive)) {
        return true;
      }

      // Filtre mantığı
      if (_filters['Ekonomik']! &&
          !requirement.toLowerCase().contains('ekonomik')) {
        return false;
      }
      if (_filters['Yüksek Performans']! &&
          !requirement.toLowerCase().contains('yüksek')) {
        return false;
      }
      if (_filters['Gıdaya Uygun']! &&
          !requirement.toLowerCase().contains('gıda')) {
        return false;
      }
      if (_filters['Geri Dönüştürülebilir']! &&
          !requirement.toLowerCase().contains('dönüş')) {
        return false;
      }

      return true;
    }).toList();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          'Filtreler',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _filters.entries.map((entry) {
            return CheckboxListTile(
              title: Text(
                entry.key,
                style: const TextStyle(color: Colors.white),
              ),
              value: entry.value,
              activeColor: Colors.tealAccent.shade700,
              onChanged: (bool? value) {
                setState(() {
                  _filters[entry.key] = value ?? false;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showRecommendations(String requirement) {
    final recommendations = _recommendations[requirement] ?? [];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Başlık
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade800,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Önerilen Malzemeler',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      requirement,
                      style: TextStyle(
                        color: Colors.tealAccent.shade100,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Öneriler Listesi
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) {
                    final recommendation = recommendations[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      color: Colors.blueGrey.shade700,
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            Text(
                              recommendation['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < recommendation['rating']
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          recommendation['description'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        onExpansionChanged: (isExpanded) {
                          if (isExpanded) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MaterialDetailScreen(
                                  material: recommendation,
                                ),
                              ),
                            );
                          }
                        },
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Öne Çıkan Özellikler:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...recommendation['details']
                                    .map<Widget>((detail) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, bottom: 4),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.tealAccent,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            detail,
                                            style: const TextStyle(
                                                color: Colors.white70),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
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
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
