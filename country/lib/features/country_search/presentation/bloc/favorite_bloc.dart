import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/country.dart';
import '../../domain/usecases/add_favorite.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/remove_favorite.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavorites getFavorites;
  final AddFavorites addFavorite;
  final RemoveFavorites removeFavorite;

  FavoriteBloc({
    required this.getFavorites,
    required this.addFavorite,
    required this.removeFavorite,
  }) : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    final result = await getFavorites();
    result.fold(
      (failure) => emit(FavoriteError(failure.message)),
      (favorites) => emit(FavoriteLoaded(favorites)),
    );
  }

  Future<void> _onAddFavorite(
    AddFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final result = await addFavorite(event.country);
    result.fold((failure) => emit(FavoriteError(failure.message)), (_) async {
      final favoritesResult = await getFavorites();
      favoritesResult.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (favorites) => emit(
          FavoriteOperationSuccess(
            favorites: favorites,
            message: 'Added to favorites',
          ),
        ),
      );
    });
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoriteState> emit,
  ) async {
    final result = await removeFavorite(event.country);
    result.fold((failure) => emit(FavoriteError(failure.message)), (_) async {
      final favoritesResult = await getFavorites();
      favoritesResult.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (favorites) => emit(
          FavoriteOperationSuccess(
            favorites: favorites,
            message: 'Removed from favorites',
          ),
        ),
      );
    });
  }
}
