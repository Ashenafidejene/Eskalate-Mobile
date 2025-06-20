import 'package:country/core/networks/api_client.dart';
import 'package:country/core/networks/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/theme/theme_bloc.dart';
import 'features/country_search/data/datasources/country_local_data_source.dart';
import 'features/country_search/data/datasources/country_remote_data_source.dart';
import 'features/country_search/data/repositories/country_repository_impl.dart';
import 'features/country_search/domain/repositories/country_repository.dart';
import 'features/country_search/domain/usecases/add_favorite.dart';
import 'features/country_search/domain/usecases/get_all_countries.dart';
import 'features/country_search/domain/usecases/get_country_detail.dart';
import 'features/country_search/domain/usecases/get_favorites.dart';
import 'features/country_search/domain/usecases/remove_favorite.dart';
import 'features/country_search/domain/usecases/search_countries.dart';
import 'features/country_search/presentation/bloc/country_bloc.dart';
import 'features/country_search/presentation/bloc/favorite_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Country Search
  // Bloc
  sl.registerFactory(
    () => CountryBloc(
      getAllCountries: sl(),
      getCountryDetail: sl(),
      searchCountries: sl(),
    ),
  );

  sl.registerFactory(
    () => FavoriteBloc(
      getFavorites: sl(),
      addFavorite: sl(),
      removeFavorite: sl(),
    ),
  );

  // Theme Bloc
  sl.registerFactory(() => ThemeBloc());

  // Use cases
  sl.registerLazySingleton(() => GetAllCountries(sl()));
  sl.registerLazySingleton(() => GetCountryDetail(sl()));
  sl.registerLazySingleton(() => SearchCountriess(sl()));
  sl.registerLazySingleton(() => AddFavorites(sl()));
  sl.registerLazySingleton(() => RemoveFavorites(sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));

  // Repository
  sl.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<CountryLocalDataSource>(
    () => CountryLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient(client: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}
