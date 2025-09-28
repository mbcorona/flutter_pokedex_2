part of 'pokemon_bloc.dart';

@freezed
class PokemonState with _$PokemonState {
  const factory PokemonState.initial() = Initial;
  const factory PokemonState.loading() = Loading;
  const factory PokemonState.loaded({required PokemonDetails pokemon}) = Loaded;
  const factory PokemonState.error() = Error;
}
