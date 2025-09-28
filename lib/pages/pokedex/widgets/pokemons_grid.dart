import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/pokedex/pokedex_bloc.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemon_card.dart';
import 'package:pokeapi/domain/models/models.dart';

class PokemonsGrid extends StatelessWidget {
  const PokemonsGrid({super.key, required this.pokeList});

  final PokeList pokeList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 4.5),
      itemCount: pokeList.results.length + (pokeList.next != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == pokeList.results.length) {
          context.read<PokedexBloc>().add(PokedexEvent.loadMore());
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }
        return PokemonCard(pokemon: pokeList.results[index]);
      },
    );
  }
}
