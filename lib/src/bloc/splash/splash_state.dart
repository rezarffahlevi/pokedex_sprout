

import 'package:equatable/equatable.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class SplashState extends Equatable {
  final ViewData data;

  const SplashState({
    this.data = const ViewData(),
  });

  SplashState copyWith({
    ViewData? data,
  }) {
    return SplashState(
      data: data ?? this.data,
    );
  }

  @override
  List get props => [
        data,
      ];
}
