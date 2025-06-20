import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/theme/theme_bloc.dart';
import '../bloc/country_bloc.dart';
import '../widgets/country_grid.dart';
import '../widgets/search_bar.dart';
import 'favorites_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8.0), child: SearchBarWidget()),
          Expanded(
            child: BlocBuilder<CountryBloc, CountryState>(
              builder: (context, state) {
                return switch (state) {
                  CountryLoading() => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                  ),
                  CountryLoaded(:final countries) => CountryGrid(
                    countries: countries,
                  ),
                  CountryError(:final message) => Center(child: Text(message)),
                  _ => const Center(child: Text('Search for countries')),
                };
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesPage()),
            );
          }
        },
      ),
    );
  }
}
