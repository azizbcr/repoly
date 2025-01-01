import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import './custom_card.dart';

class MaterialCard extends StatelessWidget {
  final String name;
  final String abbreviation;
  final String description;
  final List<String> keyFeatures;
  final VoidCallback onTap;

  const MaterialCard({
    required this.name,
    required this.abbreviation,
    required this.description,
    required this.keyFeatures,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık ve kısaltma
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  abbreviation,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Açıklama
          Text(
            description,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),

          // Öne çıkan özellikler
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: keyFeatures.map((feature) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  feature,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
