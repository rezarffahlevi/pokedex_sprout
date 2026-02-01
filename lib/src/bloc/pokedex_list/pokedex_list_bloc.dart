import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_list/pokedex_list_state.dart';
import 'package:pokedex_sprout/src/injection.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_local.dart';
import 'package:pokedex_sprout/src/utils/pokedex_bootstrap.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class PokedexListBloc extends Cubit<PokedexListState> {
  PokedexListBloc() : super(const PokedexListState());
  PokedexRepoLocal get local => inject<PokedexRepoLocal>();

  init() async {
    getList();
  }

  getList({bool loadMore = false}) async {
    try {
      if (loadMore) {
        emit(
          state.copyWith(
            data: ViewData.loadMore(state.data.data),
            page: state.page + 1,
          ),
        );
      } else {
        emit(state.copyWith(data: ViewData.loading(), page: 1));
      }
      final res = await local.getList(page: state.page);
      log('res ${res.length} page: ${state.page} ${PokedexBootstrap.process} < ${PokedexBootstrap.dataLength}}');
      List<PokedexModel> result = loadMore
          ? [...state.data.data ?? [], ...res]
          : res;
      if (res.isEmpty) {
        if (PokedexBootstrap.process < PokedexBootstrap.dataLength) {
          emit(
            state.copyWith(data: ViewData.loaded(result), page: state.page - 1),
          );
          return;
        }
        emit(state.copyWith(data: ViewData.noData()));
      } else {
        emit(state.copyWith(data: ViewData.loaded(result)));
      }
    } catch (e) {
      log('catch ${e}');
      emit(state.copyWith(data: ViewData.error(e.toString())));
    }
  }
}
