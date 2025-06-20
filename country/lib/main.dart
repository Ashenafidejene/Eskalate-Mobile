import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/country_search/presentation/bloc/country_bloc.dart';
import 'features/country_search/presentation/bloc/favorite_bloc.dart';
import 'injection_container.dart' as di;

import 'core/theme/theme_bloc.dart';
import 'features/country_search/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ThemeBloc>()),
        BlocProvider(
          create: (_) => di.sl<CountryBloc>()..add(LoadAllCountries()),
        ),
        BlocProvider(
          create: (_) => di.sl<FavoriteBloc>()..add(LoadFavorites()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Countries Explorer',
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
