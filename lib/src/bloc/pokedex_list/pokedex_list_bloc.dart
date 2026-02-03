import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_sprout/src/bloc/pokedex_list/pokedex_list_state.dart';
import 'package:pokedex_sprout/src/injection.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_api.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class PokedexListBloc extends Cubit<PokedexListState> {
  PokedexListBloc() : super(const PokedexListState());
  final repo = inject<PokedexRepoApi>();

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
      final res = await repo.getList(page: state.page);
      log('page: ${state.page} length:${res.length}');
      List<PokedexModel> result = loadMore
          ? [...state.data.data ?? [], ...res]
          : res;
      if (res.isEmpty) {
        emit(state.copyWith(data: ViewData.noData()));
      } else {
        emit(state.copyWith(data: ViewData.loaded(result)));
        mappingDetail(res);
      }
    } catch (e) {
      emit(state.copyWith(data: ViewData.error(e.toString())));
    }
  }

  mappingDetail(List<PokedexModel> res) async {
    for (var e in res) {
      if (e.id != null) {
        final detail = await repo.getDetail(e.id!);
        final index = state.data.data?.indexWhere((test) => test.id == e.id);

        List<PokedexModel> result = state.data.data ?? [];
        if (index != null && index >= 0) {
          result[index] = detail;
        } else {
          result.add(detail);
        }
        emit(state.copyWith(data: ViewData.loaded(result)));
      }
    }
  }
}
