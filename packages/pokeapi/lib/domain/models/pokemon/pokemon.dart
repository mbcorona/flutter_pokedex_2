import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokeapi/domain/models/pokemon/pokemon_details.dart';

part 'pokemon.g.dart';
part 'pokemon.freezed.dart';

@freezed
abstract class Pokemon with _$Pokemon {
  const factory Pokemon({
    required String name,
    required String url,
    PokemonDetails? details,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, Object?> json) => _$PokemonFromJson(json);
}

extension PokemonX on Pokemon {
  String get id => url.split('/').reversed.elementAt(1);
  String get image => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png';
}
