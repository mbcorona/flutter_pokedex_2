import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/pokedex/pokemons_bloc.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemon_card.dart';
import 'package:flutter_pokedex_2/widgets/pokemon_loader.dart';

class AllPokemonsGrid extends StatefulWidget {
  const AllPokemonsGrid({super.key});

  @override
  State<AllPokemonsGrid> createState() => _AllPokemonsGridState();
}

class _AllPokemonsGridState extends State<AllPokemonsGrid> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => PokemonsBloc()..add(PokemonsEvent.load()),
      child: BlocBuilder<PokemonsBloc, PokemonsState>(
        builder: (context, state) {
          switch (state) {
            case Initial():
            case Loading():
              return PokemonLoader();
            case Loaded():
              final pokemons = state.pokemons;
              final hasMore = state.pokeList.next != null;
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        context.read<PokemonsBloc>().add(PokemonsEvent.search(value));
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: pokemons.length + (hasMore ? 1 : 0),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        if (index == pokemons.length) {
                          context.read<PokemonsBloc>().add(PokemonsEvent.loadMore());
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        }
                        return PokemonCard(pokemon: pokemons[index]);
                      },
                    ),
                  ),
                ],
              );
            case Error():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Error loading pokemons', style: TextStyle(color: Colors.white)),
                    ElevatedButton(
                      onPressed: () => context.read<PokemonsBloc>().add(PokemonsEvent.load()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
