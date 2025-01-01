import 'package:flutter/material.dart';
import '../models/polymer.dart';
import '../theme/app_colors.dart';

class FilterResultsScreen extends StatelessWidget {
  final List<Polymer> polymers;

  const FilterResultsScreen({
    super.key,
    required this.polymers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Önerilen Malzemeler'),
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
        child: ListView.builder(
          itemCount: polymers.length,
          itemBuilder: (context, index) {
            final polymer = polymers[index];
            return Card(
              margin: const EdgeInsets.all(8),
              color: AppColors.surface,
              child: ListTile(
                title: Text(
                  polymer.name,
                  style: const TextStyle(color: AppColors.white),
                ),
                subtitle: Text(
                  polymer.abbreviation,
                  style: TextStyle(color: AppColors.grey),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.grey,
                  size: 16,
                ),
                onTap: () {
                  // Detay sayfasına git
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
