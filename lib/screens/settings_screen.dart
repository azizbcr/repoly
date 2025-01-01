import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Yardımcı metodları buraya taşıyalım
  Widget _buildFontSizeOption(BuildContext context, String label, double size) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: size,
        ),
      ),
      trailing: Radio<String>(
        value: label,
        groupValue: 'Orta',
        onChanged: (value) {
          Navigator.pop(context);
        },
        fillColor: MaterialStateProperty.all(Colors.tealAccent.shade200),
      ),
    );
  }

  Widget _buildViewOption(BuildContext context, String label, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.tealAccent.shade200),
      title: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Radio<String>(
        value: label,
        groupValue: 'Kompakt',
        onChanged: (value) {
          Navigator.pop(context);
        },
        fillColor: MaterialStateProperty.all(Colors.tealAccent.shade200),
      ),
    );
  }

  Widget _buildSortOption(BuildContext context, String label) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Radio<String>(
        value: label,
        groupValue: 'İsme göre',
        onChanged: (value) {
          Navigator.pop(context);
        },
        fillColor: MaterialStateProperty.all(Colors.tealAccent.shade200),
      ),
    );
  }

  // Dialog çağrılarını da güncelleyelim
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ayarlar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.black],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection(
              'Görünüm',
              [
                _buildSettingTile(
                  icon: Icons.text_fields,
                  title: 'Yazı Boyutu',
                  subtitle: 'Orta',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.surface,
                        title: const Text(
                          'Yazı Boyutu',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildFontSizeOption(context, 'Küçük', 14),
                            _buildFontSizeOption(context, 'Orta', 16),
                            _buildFontSizeOption(context, 'Büyük', 18),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                _buildSettingTile(
                  icon: Icons.format_list_bulleted,
                  title: 'Liste Görünümü',
                  subtitle: 'Kompakt',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.surface,
                        title: const Text(
                          'Liste Görünümü',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildViewOption(
                                context, 'Kompakt', Icons.view_agenda),
                            _buildViewOption(
                                context, 'Genişletilmiş', Icons.view_day),
                            _buildViewOption(context, 'Grid', Icons.grid_view),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                _buildSettingTile(
                  icon: Icons.sort,
                  title: 'Varsayılan Sıralama',
                  subtitle: 'İsme göre',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.surface,
                        title: const Text(
                          'Varsayılan Sıralama',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildSortOption(context, 'İsme göre'),
                            _buildSortOption(context, 'Kategoriye göre'),
                            _buildSortOption(context, 'Son kullanıma göre'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Uygulama',
              [
                _buildSettingTile(
                  icon: Icons.color_lens,
                  title: 'Tema',
                  subtitle: 'Koyu tema',
                  onTap: () {
                    // Tema değiştirme işlevi
                  },
                ),
                _buildSettingTile(
                  icon: Icons.language,
                  title: 'Dil',
                  subtitle: 'Türkçe',
                  onTap: () {
                    // Dil değiştirme işlevi
                  },
                ),
                _buildSettingTile(
                  icon: Icons.notifications,
                  title: 'Bildirimler',
                  subtitle: 'Açık',
                  onTap: () {
                    // Bildirim ayarları
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Veri',
              [
                _buildSettingTile(
                  icon: Icons.cloud_download,
                  title: 'Veritabanını Güncelle',
                  subtitle: 'Son güncelleme: 1 gün önce',
                  onTap: () {
                    // Güncelleme işlevi
                  },
                ),
                _buildSettingTile(
                  icon: Icons.delete_outline,
                  title: 'Önbelleği Temizle',
                  subtitle: '45 MB kullanılıyor',
                  onTap: () {
                    // Temizleme işlevi
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Hakkında',
              [
                _buildSettingTile(
                  icon: Icons.info_outline,
                  title: 'Uygulama Bilgisi',
                  subtitle: 'Versiyon 1.0.0',
                  onTap: () {
                    // Bilgi gösterme işlevi
                  },
                ),
                _buildSettingTile(
                  icon: Icons.contact_support_outlined,
                  title: 'Destek',
                  subtitle: 'Yardım ve geri bildirim',
                  onTap: () {
                    // Destek sayfası
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.tealAccent.shade200),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.white54,
      ),
      onTap: onTap,
    );
  }
}
