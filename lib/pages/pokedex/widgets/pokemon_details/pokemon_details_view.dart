import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/pokemon/pokemon_bloc.dart';
import 'package:flutter_pokedex_2/bloc/selected_pokemon/selected_pokemon_cubit.dart';
import 'package:flutter_pokedex_2/constants.dart';
import 'package:flutter_pokedex_2/pages/pokedex/widgets/pokemon_details/stat_bar_chart.dart';
import 'package:flutter_pokedex_2/utils.dart';
import 'package:flutter_pokedex_2/widgets/pokemon_favorite_button.dart';
import 'package:pokeapi/domain/models/models.dart';

class PokemonDetailsView extends StatelessWidget {
  const PokemonDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedPokemonCubit, Pokemon?>(
      builder: (context, state) {
        final pokemon = state;
        if (pokemon == null) {
          return const SizedBox.shrink();
        }
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: kPadding * 1.2, right: kPadding / 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          onPressed: () {
                            context.read<SelectedPokemonCubit>().clear();
                          },
                        ),
                        Text(pokemon.name.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('#${pokemon.id.padLeft(4, '0')}'),
                        PokemonFavoriteButton(pokemon: pokemon),
                      ],
                    ),
                    Image.network(pokemon.image, height: 200),
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => PokemonBloc()..add(PokemonEvent.load(pokemon.id)),
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: kPadding * 2, right: kPadding / 4),
                    child: BlocBuilder<PokemonBloc, PokemonState>(
                      builder: (context, state) {
                        switch (state) {
                          case Initial():
                          case Loading():
                            return const Center(child: CircularProgressIndicator(color: kRedColor));
                          case Loaded():
                            final details = state.pokemon;
                            return _details(details);
                          case Error():
                            return const Center(child: Text('Something went wrong'));
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _details(PokemonDetails details) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: kPadding / 2),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: details.typeNames
                .map(
                  (x) => Chip(
                    backgroundColor: randomColor(),
                    label: Text(x.toUpperCase(), style: TextStyle(color: Colors.white)),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: kPadding / 2),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(details.height.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Height'),
                  ],
                ),
                Container(height: 30, width: .4, color: Colors.grey),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(details.weight.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Weight'),
                  ],
                ),
                Container(height: 30, width: .4, color: Colors.grey),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          details.abilityNames.join('\n').toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Text('Moves'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: kPadding / 2),

          StatBarChart(baseStats: details.baseStatsMap),
        ],
      ),
    );
  }
}
