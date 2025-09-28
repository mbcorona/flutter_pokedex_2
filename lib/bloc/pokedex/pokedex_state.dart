part of 'pokedex_bloc.dart';

@freezed
class PokedexState with _$PokedexState {
  const factory PokedexState.initial() = Initial;
  const factory PokedexState.loading() = Loading;
  const factory PokedexState.loaded({required PokeList<Pokemon> pokeList}) = Loaded;
  const factory PokedexState.error() = Error;
}
