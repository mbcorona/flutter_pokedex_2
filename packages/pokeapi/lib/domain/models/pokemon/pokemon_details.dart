// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_details.freezed.dart';
part 'pokemon_details.g.dart';

// --- AUXILIARY CLASSES ---

@freezed
abstract class ApiNameUrl with _$ApiNameUrl {
  const factory ApiNameUrl({
    required String name,
    required String url,
  }) = _ApiNameUrl;

  factory ApiNameUrl.fromJson(Map<String, dynamic> json) => _$ApiNameUrlFromJson(json);
}

@freezed
abstract class ApiPokemonType with _$ApiPokemonType {
  const factory ApiPokemonType({
    required ApiNameUrl type,
  }) = _ApiPokemonType;

  factory ApiPokemonType.fromJson(Map<String, dynamic> json) => _$ApiPokemonTypeFromJson(json);
}

@freezed
abstract class ApiPokemonStat with _$ApiPokemonStat {
  const factory ApiPokemonStat({
    @JsonKey(name: 'base_stat') required int baseStat,
    required ApiNameUrl stat,
  }) = _ApiPokemonStat;

  factory ApiPokemonStat.fromJson(Map<String, dynamic> json) => _$ApiPokemonStatFromJson(json);
}

@freezed
abstract class ApiPokemonAbility with _$ApiPokemonAbility {
  const factory ApiPokemonAbility({
    required ApiNameUrl ability,
    @JsonKey(name: 'is_hidden') required bool isHidden,
  }) = _ApiPokemonAbility;

  factory ApiPokemonAbility.fromJson(Map<String, dynamic> json) => _$ApiPokemonAbilityFromJson(json);
}

@freezed
abstract class ApiPokemonSprites with _$ApiPokemonSprites {
  const factory ApiPokemonSprites({
    required ApiOfficialArtwork other,
  }) = _ApiPokemonSprites;

  factory ApiPokemonSprites.fromJson(Map<String, dynamic> json) => _$ApiPokemonSpritesFromJson(json);
}

@freezed
abstract class ApiOfficialArtwork with _$ApiOfficialArtwork {
  const factory ApiOfficialArtwork({
    @JsonKey(name: 'official-artwork') required ApiOfficialArtworkDetails officialArtwork,
  }) = _ApiOfficialArtwork;

  factory ApiOfficialArtwork.fromJson(Map<String, dynamic> json) => _$ApiOfficialArtworkFromJson(json);
}

@freezed
abstract class ApiOfficialArtworkDetails with _$ApiOfficialArtworkDetails {
  const factory ApiOfficialArtworkDetails({
    @JsonKey(name: 'front_default') required String frontDefault,
  }) = _ApiOfficialArtworkDetails;

  factory ApiOfficialArtworkDetails.fromJson(Map<String, dynamic> json) => _$ApiOfficialArtworkDetailsFromJson(json);
}

// --- MAIN CLASS ---

@freezed
abstract class PokemonDetails with _$PokemonDetails {
  const factory PokemonDetails({
    required int id,
    required String name,
    required double height,
    required double weight,
    required List<ApiPokemonType> types,
    required List<ApiPokemonStat> stats,
    required List<ApiPokemonAbility> abilities,
    required ApiPokemonSprites sprites,
    required ApiNameUrl species,
  }) = _PokemonDetails;

  factory PokemonDetails.fromJson(Map<String, Object?> json) => _$PokemonDetailsFromJson(json);
}

// --- EXTENSION / GETTERS ---

extension PokemonDetailsX on PokemonDetails {
  int get number => id;

  String get officialImage => sprites.other.officialArtwork.frontDefault;

  List<String> get typeNames {
    return types.map((e) => e.type.name).toList();
  }

  List<String> get abilityNames {
    return abilities.map((e) => e.ability.name).toList();
  }

  String get evolutionChainUrl {
    return species.url;
  }

  Map<String, int> get baseStatsMap {
    return Map.fromEntries(
      stats.map((e) => MapEntry(e.stat.name, e.baseStat)),
    );
  }

  String get image => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png';
}
