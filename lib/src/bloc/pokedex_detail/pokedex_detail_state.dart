import 'package:equatable/equatable.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class PokedexDetailState extends Equatable {
  final ViewData<PokedexModel> pokedex;

  const PokedexDetailState({
    this.pokedex = const ViewData(),
  });

  PokedexDetailState copyWith({
    ViewData<PokedexModel>? pokedex,
  }) {
    return PokedexDetailState(
      pokedex: pokedex ?? this.pokedex,
    );
  }

  @override
  List get props => [pokedex];
}
