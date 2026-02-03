import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_state.dart';
import 'package:pokedex_sprout/src/injection.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_api.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class PokedexDetailBloc extends Cubit<PokedexDetailState> {
  PokedexDetailBloc() : super(const PokedexDetailState());
  final repo = inject<PokedexRepoApi>();

  init(pokedex) async {
    getSpecies(pokedex?.id);
    emit(state.copyWith(pokedex: ViewData.loaded(pokedex)));
  }

  getSpecies(int id) async {
    try {
      final species = await repo.getSpecies(id);
      PokedexModel? pokedex = state.pokedex.data;
      pokedex?.species = species;
      emit(state.copyWith(pokedex: ViewData.loaded(pokedex)));
    } catch (e) {
      emit(state.copyWith(pokedex: ViewData.error(e.toString())));
    }
  }
}
