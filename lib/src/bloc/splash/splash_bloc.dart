import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_state.dart';
import 'package:pokedex_sprout/src/injection.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_api.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_local.dart';
import 'package:pokedex_sprout/src/utils/app_database.dart';
import 'package:pokedex_sprout/src/utils/pokedex_bootstrap.dart';
import 'package:pokedex_sprout/src/utils/utils.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class SplashBloc extends Cubit<SplashState> {
  SplashBloc() : super(const SplashState());
  PokedexBootstrap get bootstrap => inject<PokedexBootstrap>();

  init() async {
    try {
      // bootstrap.start();
      await Utils.addDelay(1);
      emit(state.copyWith(data: ViewData.loaded('completed')));
    } catch (e) {
      emit(state.copyWith(data: ViewData.error(e.toString())));
    }
  }
}
