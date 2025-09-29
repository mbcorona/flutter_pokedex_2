import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pokeapi/domain/models/pokemon/pokemon.dart';

part 'poke_favorites_bloc.freezed.dart';
part 'poke_favorites_bloc.g.dart';

// --- BLoC Events ---
// These are the actions that the UI can dispatch to the BLoC.
@freezed
abstract class PokeFavoritesEvent with _$PokeFavoritesEvent {
  /// Dispatched to add a Pokemon to the favorites list.
  const factory PokeFavoritesEvent.add(Pokemon pokemon) = _Add;

  /// Dispatched to remove a Pokemon from the favorites list.
  const factory PokeFavoritesEvent.remove(Pokemon pokemon) = _Remove;
}

// --- BLoC State ---
// This represents the state of our favorites list at any given time.
@freezed
abstract class PokeFavoritesState with _$PokeFavoritesState {
  const factory PokeFavoritesState({
    /// The list of favorite Pokemon. Defaults to an empty list.
    @Default([]) List<Pokemon> favorites,
  }) = _PokeFavoritesState;

  /// A factory constructor to create the state from a JSON object.
  /// This is used by HydratedBloc to restore the state.
  factory PokeFavoritesState.fromJson(Map<String, dynamic> json) => _$PokeFavoritesStateFromJson(json);

  // A private constructor is needed to add custom methods to a freezed class.
  const PokeFavoritesState._();

  /// A helper method to quickly check if a Pokemon is already a favorite.
  bool isFavorite(Pokemon pokemon) {
    return favorites.any((p) => p.id == pokemon.id);
  }
}

// --- BLoC Implementation ---
// This class extends HydratedBloc to automatically persist its state.
class PokeFavoritesBloc extends HydratedBloc<PokeFavoritesEvent, PokeFavoritesState> {
  /// The initial state is an empty list of favorites.
  PokeFavoritesBloc() : super(const PokeFavoritesState()) {
    on<_Add>(_onAdd);
    on<_Remove>(_onRemove);
  }

  /// Handles the [_Add] event.
  void _onAdd(_Add event, Emitter<PokeFavoritesState> emit) {
    // We check if the pokemon is already a favorite to avoid duplicates.
    if (state.isFavorite(event.pokemon)) return;

    // Create a new list with the added pokemon and emit the new state.
    final updatedFavorites = [...state.favorites, event.pokemon];
    emit(state.copyWith(favorites: updatedFavorites));
  }

  /// Handles the [_Remove] event.
  void _onRemove(_Remove event, Emitter<PokeFavoritesState> emit) {
    // Create a new list, filtering out the pokemon to be removed.
    final updatedFavorites = state.favorites.where((p) => p.id != event.pokemon.id).toList();
    emit(state.copyWith(favorites: updatedFavorites));
  }

  /// Called by HydratedBloc to convert the state to a JSON map for storage.
  @override
  Map<String, dynamic>? toJson(PokeFavoritesState state) {
    return state.toJson();
  }

  /// Called by HydratedBloc to convert a JSON map from storage back to a state object.
  @override
  PokeFavoritesState? fromJson(Map<String, dynamic> json) {
    try {
      return PokeFavoritesState.fromJson(json);
    } catch (_) {
      // If parsing fails, return null to use the initial state.
      return null;
    }
  }
}
