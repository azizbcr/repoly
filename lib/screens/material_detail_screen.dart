import 'package:flutter/material.dart';

class MaterialDetailScreen extends StatelessWidget {
  final Map<String, dynamic> material;

  // Örnek uygulama görselleri (gerçek uygulamada asset olarak eklenecek)
  final List<Map<String, String>> applications = [
    {
      'name': 'Otomotiv Parçaları',
      'image': 'assets/images/automotive.jpg',
      'description': 'Tampon, gösterge paneli, iç trim parçaları',
    },
    {
      'name': 'Ev Aletleri',
      'image': 'assets/images/appliances.jpg',
      'description': 'Beyaz eşya parçaları, küçük ev aletleri',
    },
    // Diğer uygulamalar...
  ];

  // İşleme parametreleri
  final Map<String, Map<String, String>> processingParameters = {
    'Enjeksiyon': {
      'Eriyik Sıcaklığı': '190-230°C',
      'Kalıp Sıcaklığı': '20-40°C',
      'Enjeksiyon Basıncı': '80-120 MPa',
      'Kurutma': '80°C / 2-4 saat',
    },
    'Ekstrüzyon': {
      'Eriyik Sıcaklığı': '180-220°C',
      'Vida Hızı': '20-40 rpm',
      'Soğutma': 'Su banyosu',
    },
  };

  // Tedarikçi bilgileri
  final List<Map<String, String>> suppliers = [
    {
      'name': 'PolymerCo',
      'location': 'İstanbul',
      'contact': '+90 212 XXX XX XX',
      'minOrder': '25 kg',
      'leadTime': '3-5 iş günü',
    },
    {
      'name': 'PlasticTR',
      'location': 'İzmir',
      'contact': '+90 232 XXX XX XX',
      'minOrder': '50 kg',
      'leadTime': '1-2 hafta',
    },
  ];

  MaterialDetailScreen({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(material['name']),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => _showQRCode(context),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık Kartı
              Card(
                margin: const EdgeInsets.all(16),
                color: Colors.blueGrey.shade800,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            material['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < material['rating']
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        material['description'],
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Teknik Özellikler
              _buildSection(
                'Teknik Özellikler',
                [
                  _buildPropertyTile('Yoğunluk', '0.91-0.97 g/cm³'),
                  _buildPropertyTile('Erime Sıcaklığı', '160-170°C'),
                  _buildPropertyTile('Çekme Mukavemeti', '25-35 MPa'),
                  _buildPropertyTile('Su Emme', '<%0.01'),
                  _buildPropertyTile('Darbe Dayanımı', 'İyi'),
                ],
              ),

              // Kullanım Alanları
              _buildSection(
                'Kullanım Alanları',
                [
                  _buildBulletPoint('Otomotiv parçaları'),
                  _buildBulletPoint('Ambalaj ürünleri'),
                  _buildBulletPoint('Ev eşyaları'),
                  _buildBulletPoint('Endüstriyel uygulamalar'),
                ],
              ),

              // İşleme Yöntemleri
              _buildSection(
                'İşleme Yöntemleri',
                [
                  _buildBulletPoint('Enjeksiyon kalıplama'),
                  _buildBulletPoint('Ekstrüzyon'),
                  _buildBulletPoint('Şişirme kalıplama'),
                  _buildBulletPoint('Termoform'),
                ],
              ),

              // Avantajlar ve Dezavantajlar
              Row(
                children: [
                  Expanded(
                    child: _buildSection(
                      'Avantajlar',
                      [
                        _buildBulletPoint('Ekonomik'),
                        _buildBulletPoint('Kolay işlenebilir'),
                        _buildBulletPoint('Kimyasal direnci yüksek'),
                      ],
                      color: Colors.green.withOpacity(0.1),
                    ),
                  ),
                  Expanded(
                    child: _buildSection(
                      'Dezavantajlar',
                      [
                        _buildBulletPoint('UV dayanımı düşük'),
                        _buildBulletPoint('Çizilmeye duyarlı'),
                        _buildBulletPoint('Yapışma zorluğu'),
                      ],
                      color: Colors.red.withOpacity(0.1),
                    ),
                  ),
                ],
              ),

              // Fiyat Bilgisi
              _buildSection(
                'Fiyat Aralığı',
                [
                  _buildPropertyTile('Piyasa Fiyatı', '2-3 €/kg'),
                  _buildPropertyTile('Minimum Sipariş', '25 kg'),
                  _buildPropertyTile('Tedarik Süresi', '1-2 hafta'),
                ],
              ),

              // Örnek Uygulamalar
              _buildSection(
                'Örnek Uygulamalar',
                [_buildApplicationsGallery()],
              ),

              // İşleme Parametreleri
              _buildSection(
                'İşleme Parametreleri',
                [_buildProcessingParameters()],
              ),

              // Tedarikçiler
              _buildSection(
                'Tedarikçiler',
                [_buildSuppliersList()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, {Color? color}) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: color ?? Colors.blueGrey.shade800,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.tealAccent.shade100,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyTile(String property, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            property,
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: Colors.tealAccent.shade100,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsGallery() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: applications.length,
        itemBuilder: (context, index) {
          final app = applications[index];
          return Card(
            margin: const EdgeInsets.all(8),
            color: Colors.blueGrey.shade700,
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    color: Colors.blueGrey.shade600,
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Colors.white54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          app['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          app['description']!,
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProcessingParameters() {
    return Column(
      children: processingParameters.entries.map((entry) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.blueGrey.shade700,
          child: ExpansionTile(
            title: Text(
              entry.key,
              style: const TextStyle(color: Colors.white),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: entry.value.entries.map((param) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            param.key,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            param.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuppliersList() {
    return Column(
      children: suppliers.map((supplier) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: Colors.blueGrey.shade700,
          child: ListTile(
            title: Text(
              supplier['name']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Konum: ${supplier['location']}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Min. Sipariş: ${supplier['minOrder']}',
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  'Tedarik Süresi: ${supplier['leadTime']}',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.phone, color: Colors.tealAccent),
              onPressed: () {
                // Telefon numarasını arama işlevi eklenebilir
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          'QR Kod',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.white,
              child: const Center(
                child: Icon(Icons.qr_code, size: 150),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bu QR kodu tarayarak ${material['name']} hakkında detaylı bilgiye ulaşabilirsiniz.',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
