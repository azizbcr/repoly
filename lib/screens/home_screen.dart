import 'package:flutter/material.dart';
import '../screens/material_library_screen.dart';
import '../screens/test_screen.dart';
import '../screens/material_selector_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black, Colors.blueGrey.shade900],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Hoş Geldiniz Kartı
            Card(
              margin: const EdgeInsets.all(16),
              color: Colors.blueGrey.shade800,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'RePoly\'ye Hoş Geldiniz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Polimer malzemeler hakkında detaylı bilgi, test prosedürleri ve malzeme seçim asistanı.',
                      style: TextStyle(
                        color: Colors.tealAccent.shade100,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Hızlı Erişim Kartları
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildQuickAccessCard(
                    context,
                    'Polimer Kütüphanesi',
                    'Tüm polimer malzemeleri keşfedin',
                    Icons.library_books,
                    () => _navigateToLibrary(context),
                  ),
                  const SizedBox(height: 12),
                  _buildQuickAccessCard(
                    context,
                    'Test Prosedürleri',
                    'ISO standartları ve test yöntemleri',
                    Icons.science,
                    () => _navigateToTests(context),
                  ),
                  const SizedBox(height: 12),
                  _buildQuickAccessCard(
                    context,
                    'Malzeme Seçimi',
                    'Uygulamanıza göre malzeme önerileri',
                    Icons.help_outline,
                    () => _navigateToSelector(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(BuildContext context, String title,
      String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      color: Colors.blueGrey.shade700,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.tealAccent.shade700.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.tealAccent.shade100),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.tealAccent.shade100,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLibrary(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MaterialLibraryScreen(),
      ),
    );
  }

  void _navigateToTests(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Test Prosedürleri'),
            backgroundColor: Colors.black,
          ),
          body: const TestScreen(),
        ),
      ),
    );
  }

  void _navigateToSelector(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MaterialSelectorScreen(),
      ),
    );
  }
}
