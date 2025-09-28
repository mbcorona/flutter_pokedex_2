import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex_2/bloc/pokemon/pokemon_bloc.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonBloc()..add(PokemonEvent.load(id)),
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          switch (state) {
            case Initial():
            case Loading():
              return CircularProgressIndicator();
            case Loaded():
              return Text(state.pokemon.id.toString());
            case Error():
              return Text('Something went wrong, try again');
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
