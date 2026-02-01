import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_detail/pokedex_detail_state.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';


class PokedexDetailBloc extends Cubit<PokedexDetailState> {
  PokedexDetailBloc() : super(const PokedexDetailState());

  init() async {
    try {
      emit(state.copyWith(data: ViewData.loaded('')));
    } catch (e) {
      emit(state.copyWith(data: ViewData.error(e.toString())));
    }
  }
}
