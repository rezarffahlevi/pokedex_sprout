import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_sprout/src/bloc/splash/splash_state.dart';
import 'package:pokedex_sprout/src/utils/utils.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class SplashBloc extends Cubit<SplashState> {
  SplashBloc() : super(const SplashState());

  init() async {
    try {
      await Utils.addDelay(1);
      emit(state.copyWith(data: ViewData.loaded('completed')));
    } catch (e) {
      emit(state.copyWith(data: ViewData.error(e.toString())));
    }
  }
}
