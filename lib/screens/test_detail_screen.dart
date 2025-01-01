import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'test_screen.dart';

class TestDetailScreen extends StatelessWidget {
  final TestProcedure test;

  const TestDetailScreen({
    super.key,
    required this.test,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(test.name),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSection('Test Standardı', test.standard),
              const SizedBox(height: 24),
              _buildParametersSection(),
              const SizedBox(height: 24),
              _buildEquipmentSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCategoryIcon(test.category),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildCategoryChip(test.category),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          test.description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
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
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: Colors.tealAccent.shade200,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildParametersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Test Parametreleri',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...test.parameters.map(
          (param) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(Icons.arrow_right, color: Colors.tealAccent.shade200),
                const SizedBox(width: 8),
                Text(
                  param,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gerekli Ekipmanlar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...test.equipment.map(
          (equip) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: Colors.tealAccent.shade200),
                const SizedBox(width: 8),
                Text(
                  equip,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
}
