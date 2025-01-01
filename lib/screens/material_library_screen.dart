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

class MaterialLibraryScreen extends StatefulWidget {
  const MaterialLibraryScreen({super.key});

  @override
  State<MaterialLibraryScreen> createState() => _MaterialLibraryScreenState();
}

class _MaterialLibraryScreenState extends State<MaterialLibraryScreen> {
  final String _searchQuery = '';
  int _selectedIndex = 0;
  List<Polymer> _comparisonList = [];

  static final List<Polymer> _allPolymers = [
    Polymer(
      name: 'Polipropilen',
      abbreviation: 'PP',
      meltingTemp: 165,
      glassTransitionTemp: -10,
      meltFlowIndex: 12,
      description:
          'Yaygın kullanılan termoplastik polimer. Yüksek kimyasal dirence ve iyi mekanik özelliklere sahiptir.',
      additionalProperties: {
        'Yoğunluk': '0.90-0.91 g/cm³',
        'Çekme Mukavemeti': '30-40 MPa',
      },
    ),
    Polymer(
      name: 'Polietilen',
      abbreviation: 'PE',
      meltingTemp: 130,
      glassTransitionTemp: -120,
      meltFlowIndex: 8,
      description:
          'En yaygın plastik türü. Düşük ve yüksek yoğunluklu türleri mevcuttur.',
      additionalProperties: {
        'Yoğunluk': '0.91-0.97 g/cm³',
        'Çekme Mukavemeti': '20-45 MPa',
      },
    ),
    Polymer(
      name: 'Polistiren',
      abbreviation: 'PS',
      meltingTemp: 240,
      glassTransitionTemp: 100,
      meltFlowIndex: 10,
      description:
          'Sert ve kırılgan bir termoplastik. Şeffaf ve kolay işlenebilir.',
      additionalProperties: {
        'Yoğunluk': '1.04-1.06 g/cm³',
        'Çekme Mukavemeti': '35-50 MPa',
      },
    ),
    Polymer(
      name: 'Polivinil Klorür',
      abbreviation: 'PVC',
      meltingTemp: 200,
      glassTransitionTemp: 85,
      meltFlowIndex: 15,
      description:
          'Dayanıklı ve ekonomik bir polimer. Yapı malzemelerinde yaygın kullanılır.',
      additionalProperties: {
        'Yoğunluk': '1.3-1.45 g/cm³',
        'Çekme Mukavemeti': '40-60 MPa',
      },
    ),
    Polymer(
      name: 'Polietilen Tereftalat',
      abbreviation: 'PET',
      meltingTemp: 260,
      glassTransitionTemp: 70,
      meltFlowIndex: 20,
      description: 'İçecek şişelerinde yaygın kullanılan şeffaf polimer.',
      additionalProperties: {
        'Yoğunluk': '1.37 g/cm³',
        'Çekme Mukavemeti': '55-75 MPa',
      },
    ),
  ];

  List<Polymer> get _polymers => _allPolymers;

  List<Polymer> get _filteredPolymers => _polymers
      .where((polymer) =>
          polymer.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          polymer.abbreviation
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
      .toList();

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
    final List<Widget> screens = [
      _buildLibraryContent(),
      const TestScreen(),
      const HomeScreen(),
      const FavoritesScreen(),
      const HistoryScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Malzeme Kütüphanesi'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              ),
            );
          },
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _PolymerSearchDelegate(_polymers),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey.shade900,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.tealAccent.shade700,
                      Colors.blueGrey.shade800,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.tealAccent.shade700,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.science,
                        size: 40,
                        color: Colors.tealAccent.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'POLYWA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                icon: Icons.home,
                title: 'Ana Sayfa',
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MaterialLibraryScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.favorite,
                title: 'Favoriler',
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Favoriler yakında eklenecek!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.calculate,
                title: 'Hesaplayıcı',
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Hesaplayıcı yakında eklenecek!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.white24, thickness: 1, height: 32),
              _buildDrawerItem(
                icon: Icons.settings,
                title: 'Ayarlar',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.info,
                title: 'Hakkında',
                onTap: () {
                  Navigator.pop(context);
                  showAboutDialog(
                    context: context,
                    applicationName: 'POLYWA',
                    applicationVersion: '1.0.0',
                    applicationIcon: Icon(
                      Icons.science,
                      size: 50,
                      color: Colors.tealAccent.shade700,
                    ),
                    children: [
                      const Text(
                        'Polimer malzeme kütüphanesi ve hesaplayıcı uygulaması.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.blueGrey.shade900,
            ],
          ),
        ),
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black,
              Colors.black.withOpacity(0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.tealAccent.shade700.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.tealAccent.shade400,
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'Kütüphane',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.science),
              label: 'Testler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoriler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Geçmiş',
            ),
          ],
        ),
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
                      Provider.of<FavoritesProvider>(context, listen: false)
                          .toggleFavorite(polymer);
                    },
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                ],
              ),
              onTap: () {
                final materialData = {
                  'name': polymer.name,
                  'description': polymer.description,
                  'rating': 4,
                  'details': [
                    'Erime Sıcaklığı: ${polymer.meltingTemp}°C',
                    'Camsı Geçiş Sıcaklığı: ${polymer.glassTransitionTemp}°C',
                    'MFI: ${polymer.meltFlowIndex} g/10min',
                    ...polymer.additionalProperties.entries
                        .map((e) => '${e.key}: ${e.value}'),
                  ],
                };

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaterialDetailScreen(
                      material: materialData,
                    ),
                  ),
                );
              },
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
