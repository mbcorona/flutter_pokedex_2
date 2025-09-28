part of 'pokemon_bloc.dart';

@freezed
abstract class PokemonEvent with _$PokemonEvent {
  const factory PokemonEvent.load(String id) = _Load;
}
