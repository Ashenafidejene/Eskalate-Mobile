import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../bloc/favorite_bloc.dart';
import '../widgets/country_list_item.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return switch (state) {
            FavoriteLoading() => Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
            ),
            FavoriteLoaded(:final favorites) => ListView.builder(
              itemCount: favorites.length,
              itemBuilder:
                  (context, index) => CountryListItem(
                    country: favorites[index],
                    isFavorite: true,
                  ),
            ),
            FavoriteError(:final message) => Center(child: Text(message)),
            _ => const Center(child: Text('No favorites yet')),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
