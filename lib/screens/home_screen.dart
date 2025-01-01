import 'package:flutter/material.dart';
import '../screens/material_library_screen.dart';
import '../screens/test_screen.dart';
import '../screens/material_selector_screen.dart';
import '../screens/settings_screen.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_bottom_nav.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import '../models/polymer_fact.dart';
import '../data/polymer_facts.dart';
import '../models/daily_polymer.dart';
import '../data/featured_polymers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late DailyPolymer currentPolymer;
  late PolymerFact currentFact;

  @override
  void initState() {
    super.initState();
    _getRandomPolymer();
    _getRandomFact();
  }

  void _getRandomPolymer() {
    final random = Random();
    setState(() {
      currentPolymer =
          featuredPolymers[random.nextInt(featuredPolymers.length)];
    });
  }

  void _getRandomFact() {
    final random = Random();
    setState(() {
      currentFact = polymerFacts[random.nextInt(polymerFacts.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.black],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Üst Başlık
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.1),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.5),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.polymer,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'RePoly',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            'Polimer Malzeme Asistanı',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Günün Polimeri ve Kategoriler
                _buildDiscoverySection(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 0:
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MaterialLibraryScreen(),
                ),
              );
              break;

            case 2:
              Navigator.pushReplacement(
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

            case 3:
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

  Widget _buildDiscoverySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeaturedPolymer(context),
        const SizedBox(height: 24),
        _buildDidYouKnow(),
        const SizedBox(height: 24),
        _buildSectionTitle('Popüler Kategoriler'),
        const SizedBox(height: 16),
        _buildCategoryGrid(context),
      ],
    );
  }

  Widget _buildFeaturedPolymer(BuildContext context) {
    return GestureDetector(
      onTap: _getRandomPolymer,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              currentPolymer.color.withOpacity(0.8),
              AppColors.surface,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: currentPolymer.color,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Günün Polimeri',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white70),
                    onPressed: _getRandomPolymer,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentPolymer.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentPolymer.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: currentPolymer.properties
                        .map((prop) => _buildPropertyChip(prop))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildCategoryCard(
          'Termoplastikler',
          '45+ Polimer',
          Icons.polymer,
          Colors.blue,
          context,
        ),
        _buildCategoryCard(
          'Termosetler',
          '25+ Polimer',
          Icons.category,
          Colors.orange,
          context,
        ),
        _buildCategoryCard(
          'Elastomerler',
          '30+ Polimer',
          Icons.waves,
          Colors.purple,
          context,
        ),
        _buildCategoryCard(
          'Kompozitler',
          '50+ Polimer',
          Icons.layers,
          Colors.green,
          context,
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, String count, IconData icon,
      Color color, BuildContext context) {
    return InkWell(
      onTap: () {
        // Kategori sayfasına yönlendirme
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              count,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildDidYouKnow() {
    return GestureDetector(
      onTap: _getRandomFact,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.purple.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    color: Colors.purple,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Biliyor muydunuz?',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.purple),
                  onPressed: _getRandomFact,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              currentFact.fact,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kaynak: ${currentFact.source}',
                  style: TextStyle(
                    color: Colors.purple.shade200,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                if (currentFact.sourceUrl != null)
                  TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse(currentFact.sourceUrl!));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Daha fazla bilgi',
                          style: TextStyle(
                            color: Colors.purple.shade200,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.purple.shade200,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
