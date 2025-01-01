import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../screens/polymer_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
      child: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          if (favoritesProvider.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 48,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Henüz favori polimer eklenmedi',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kütüphaneden polimer seçerek favorilere ekleyebilirsiniz',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favoritesProvider.favorites.length,
            itemBuilder: (context, index) {
              final polymer = favoritesProvider.favorites[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                color: Colors.blueGrey.shade700,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.tealAccent.shade700,
                    child: Text(
                      polymer.abbreviation[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    polymer.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    polymer.description,
                    style: const TextStyle(color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.redAccent),
                    onPressed: () {
                      Provider.of<FavoritesProvider>(context, listen: false)
                          .toggleFavorite(polymer);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PolymerDetailScreen(polymer: polymer),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
