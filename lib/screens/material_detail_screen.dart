import 'package:flutter/material.dart';
import '../models/polymer.dart';
import '../theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Supplier {
  final String name;
  final bool inStock;
  final String deliveryTime;
  final String contact;
  final String? minOrder;

  Supplier({
    required this.name,
    required this.inStock,
    required this.deliveryTime,
    required this.contact,
    this.minOrder,
  });
}

class MaterialDetailScreen extends StatelessWidget {
  final Polymer polymer;

  final List<Supplier> suppliers = [
    Supplier(
      name: 'Emobabagh',
      inStock: true,
      deliveryTime: '1-2 hafta',
      contact: '0532 xxx xx xx',
    ),
    Supplier(
      name: 'Yarkinimsatista',
      inStock: true,
      deliveryTime: '3-4 gün',
      contact: 'info@yarkinim.com',
      minOrder: '250kg',
    ),
  ];

  MaterialDetailScreen({
    super.key,
    required this.polymer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(polymer.name),
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
              _buildHeader(),
              _buildProperties(),
              _buildApplications(),
              _buildMechanicalProperties(),
              _buildThermalProperties(),
              _buildAdditionalProperties(),
              _buildSupplierSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              polymer.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              polymer.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProperties() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Temel Özellikler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...polymer.properties.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplications() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Uygulama Alanları',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...polymer.applications.map(
              (app) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_right, color: Colors.tealAccent),
                    const SizedBox(width: 8),
                    Text(
                      app,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMechanicalProperties() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mekanik Özellikler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPropertyRow(
                'Çekme Mukavemeti', '${polymer.tensileStrength} MPa'),
            _buildPropertyRow('Kopma Uzaması', '${polymer.elongation}%'),
            _buildPropertyRow(
                'Eğilme Modülü', '${polymer.flexuralModulus} GPa'),
            _buildPropertyRow(
                'Darbe Dayanımı', '${polymer.impactStrength} kJ/m²'),
            _buildPropertyRow('Sertlik', '${polymer.hardness} Shore D'),
          ],
        ),
      ),
    );
  }

  Widget _buildThermalProperties() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Termal Özellikler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPropertyRow('Erime Sıcaklığı', '${polymer.meltingTemp}°C'),
            _buildPropertyRow(
                'Camsı Geçiş Sıcaklığı', '${polymer.glassTransitionTemp}°C'),
            _buildPropertyRow(
                'Isı Sapma Sıcaklığı', '${polymer.heatDeflection}°C'),
            _buildPropertyRow(
                'Erime Akış İndeksi', '${polymer.meltFlowIndex} g/10min'),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalProperties() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ek Özellikler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...polymer.additionalProperties.entries.map(
              (entry) => _buildPropertyRow(entry.key, entry.value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: AppColors.surface.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Tedarikçiler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(color: Colors.white24),
          ...suppliers.map((supplier) => _buildSupplierCard(supplier)).toList(),
        ],
      ),
    );
  }

  Widget _buildSupplierCard(Supplier supplier) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            supplier.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildSupplierInfo(
            Icons.inventory,
            supplier.inStock ? 'Stokta var' : 'Stokta yok',
            supplier.inStock ? Colors.green : Colors.red,
          ),
          _buildSupplierInfo(
            Icons.access_time,
            'Tedarik: ${supplier.deliveryTime}',
            Colors.white70,
          ),
          if (supplier.minOrder != null)
            _buildSupplierInfo(
              Icons.shopping_cart,
              'Minimum Sipariş: ${supplier.minOrder}',
              Colors.white70,
            ),
          _buildSupplierInfo(
            Icons.contact_phone,
            supplier.contact,
            Colors.white70,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent.shade700,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse('https://supplier-website.com'));
                  },
                  child: const Text('İletişime Geç'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierInfo(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
