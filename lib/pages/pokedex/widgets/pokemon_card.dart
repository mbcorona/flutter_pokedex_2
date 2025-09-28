import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/selected_pokemon/selected_pokemon_cubit.dart';
import 'package:flutter_pokedex_2/widgets/favorite_button.dart';
import 'package:pokeapi/domain/models/models.dart' hide PokemonDetails;

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          context.read<SelectedPokemonCubit>().select(pokemon);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Image.network(pokemon.image, height: 100),
                  Text(pokemon.name.toUpperCase()),
                  Text(pokemon.id.padLeft(4, '0'), style: TextStyle(color: Colors.grey)),
                ],
              ),
              Positioned(top: 0, right: 0, child: FavoriteButton(onTap: () {}, isFavorite: false)),
            ],
          ),
        ),
      ),
    );
  }
}
