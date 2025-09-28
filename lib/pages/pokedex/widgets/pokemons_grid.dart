import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/pokedex/pokedex_bloc.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemon_card.dart';
import 'package:pokeapi/domain/models/models.dart';

class PokemonsGrid extends StatelessWidget {
  const PokemonsGrid({super.key, required this.pokemons, required this.hasMore});

  final List<Pokemon> pokemons;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(icon: Icon(Icons.search), hintText: 'Search', border: InputBorder.none),
              onChanged: (value) {
                context.read<PokedexBloc>().add(PokedexEvent.search(value));
              },
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 4),
            itemCount: pokemons.length + (hasMore ? 1 : 0),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              if (index == pokemons.length) {
                context.read<PokedexBloc>().add(PokedexEvent.loadMore());
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              }
              return PokemonCard(pokemon: pokemons[index]);
            },
          ),
        ),
      ],
    );
  }
}
