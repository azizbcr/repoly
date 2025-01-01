import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                // Logo ve Başlık
                Icon(
                  Icons.architecture,
                  size: 80,
                  color: Colors.tealAccent.shade200,
                ),
                const SizedBox(height: 24),
                const Text(
                  'RePolymer\'e\nHoş Geldiniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 32),
                // İstatistik Kartları
                Row(
                  children: [
                    _buildStatCard(
                      '150+',
                      'Polimer',
                      Icons.category,
                      Colors.blue,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      '13',
                      'Test Prosedürü',
                      Icons.science,
                      Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildStatCard(
                      '25+',
                      'Test Cihazı',
                      Icons.precision_manufacturing,
                      Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      '100+',
                      'Standart',
                      Icons.library_books,
                      Colors.green,
                    ),
                  ],
                ),
                const Spacer(),
                // Butonlar
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent.shade700,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'BAŞLA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.tealAccent.shade200,
                    minimumSize: const Size(double.infinity, 56),
                    side: BorderSide(color: Colors.tealAccent.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'AYARLAR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String value, String label, IconData icon, Color color) {
    return Expanded(
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
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
