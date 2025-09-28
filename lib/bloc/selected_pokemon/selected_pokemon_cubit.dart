import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/domain/models/models.dart';

class SelectedPokemonCubit extends Cubit<Pokemon?> {
  SelectedPokemonCubit() : super(null);

  void select(Pokemon pokemon) => emit(pokemon);
  void clear() => emit(null);
}
