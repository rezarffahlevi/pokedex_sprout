

import 'package:equatable/equatable.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class PokedexDetailState extends Equatable {
  final ViewData data;

  const PokedexDetailState({
    this.data = const ViewData(),
  });

  PokedexDetailState copyWith({
    ViewData? data,
  }) {
    return PokedexDetailState(
      data: data ?? this.data,
    );
  }

  @override
  List get props => [
        data,
      ];
}
