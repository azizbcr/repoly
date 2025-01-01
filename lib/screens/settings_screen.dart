import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _viewMode = SettingsService.defaultViewMode;
  String _tempUnit = SettingsService.defaultTempUnit;
  String _language = SettingsService.defaultLanguage;
  bool _notifications = SettingsService.defaultNotifications;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await SettingsService.loadSettings();
    setState(() {
      _viewMode = settings['viewMode'];
      _tempUnit = settings['tempUnit'];
      _language = settings['language'];
      _notifications = settings['notifications'];
    });
  }

  Future<void> _showOptionsDialog(String title, List<String> options,
      String currentValue, String settingKey) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((option) => RadioListTile<String>(
                    title: Text(option,
                        style: const TextStyle(color: Colors.white)),
                    value: option,
                    groupValue: currentValue,
                    onChanged: (value) {
                      Navigator.pop(context, value);
                    },
                    activeColor: Colors.tealAccent.shade200,
                  ))
              .toList(),
        ),
      ),
    );

    if (result != null) {
      setState(() {
        switch (settingKey) {
          case 'viewMode':
            _viewMode = result;
            break;
          case 'tempUnit':
            _tempUnit = result;
            break;
          case 'language':
            _language = result;
            break;
        }
      });
      await SettingsService.saveSetting(settingKey, result);
    }
  }

  Future<void> _showCacheDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          'Veri Yönetimi',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.white),
              title: const Text('Önbelleği Temizle',
                  style: TextStyle(color: Colors.white)),
              subtitle:
                  Text('0.0 MB', style: TextStyle(color: Colors.grey.shade400)),
              onTap: () {
                // Önbellek temizleme işlemi
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Önbellek temizlendi')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh, color: Colors.white),
              title: const Text('Ayarları Sıfırla',
                  style: TextStyle(color: Colors.white)),
              onTap: () async {
                // Ayarları sıfırlama işlemi
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                await _loadSettings();
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ayarlar sıfırlandı')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade900,
              Colors.black,
            ],
          ),
        ),
        child: ListView(
          children: [
            // Görünüm Ayarları
            _buildSectionHeader('Görünüm'),
            _buildThemeToggle(),
            _buildSettingCard(
              'Varsayılan Görünüm',
              _viewMode,
              Icons.view_list,
              onTap: () => _showOptionsDialog(
                'Görünüm Seçin',
                ['Liste', 'Kart', 'Detaylı'],
                _viewMode,
                'viewMode',
              ),
            ),

            // Birim Ayarları
            _buildSectionHeader('Birimler'),
            _buildSettingCard(
              'Sıcaklık Birimi',
              _tempUnit,
              Icons.thermostat,
              onTap: () => _showOptionsDialog(
                'Birim Seçin',
                ['°C', '°F', 'K'],
                _tempUnit,
                'tempUnit',
              ),
            ),

            // Uygulama Ayarları
            _buildSectionHeader('Uygulama'),
            _buildSettingCard(
              'Dil',
              _language,
              Icons.language,
              onTap: () => _showOptionsDialog(
                'Dil Seçin',
                ['Türkçe', 'English'],
                _language,
                'language',
              ),
            ),
            _buildSettingCard(
              'Bildirimler',
              _notifications ? 'Açık' : 'Kapalı',
              Icons.notifications,
              onTap: () async {
                setState(() {
                  _notifications = !_notifications;
                });
                await SettingsService.saveSetting(
                    'notifications', _notifications);
              },
            ),
            _buildSettingCard(
              'Veri Yönetimi',
              'Önbellek ve veriler',
              Icons.storage,
              onTap: () => _showCacheDialog(),
            ),

            // Hakkında
            _buildSectionHeader('Hakkında'),
            _buildSettingCard(
              'Uygulama Versiyonu',
              '1.0.0',
              Icons.info,
              onTap: () {
                // Versiyon bilgisi
              },
            ),
            _buildSettingCard(
              'Lisans',
              'Açık kaynak lisanslar',
              Icons.description,
              onTap: () {
                // Lisans bilgileri
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.tealAccent.shade100,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    String title,
    String subtitle,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: Colors.blueGrey.shade800.withOpacity(0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.tealAccent.shade700.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.tealAccent.shade700.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.tealAccent.shade200,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey.shade600,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          color: Colors.blueGrey.shade800.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.tealAccent.shade700.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.tealAccent.shade700.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.dark_mode,
                    color: Colors.tealAccent.shade200,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Karanlık Mod',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Koyu renk teması',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => themeProvider.toggleTheme(),
                  child: Container(
                    width: 48,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: themeProvider.isDarkMode
                          ? Colors.tealAccent.shade700
                          : Colors.grey.shade700,
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          alignment: themeProvider.isDarkMode
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
