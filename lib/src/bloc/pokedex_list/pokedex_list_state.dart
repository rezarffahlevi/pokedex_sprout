import 'package:equatable/equatable.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/utils/view_data.dart';

class PokedexListState extends Equatable {
  final ViewData<List<PokedexModel>> data;
  final int page;

  const PokedexListState({this.data = const ViewData(), this.page = 1});

  PokedexListState copyWith({ViewData<List<PokedexModel>>? data, int? page}) {
    return PokedexListState(data: data ?? this.data, page: page ?? this.page);
  }

  @override
  List get props => [data, page];
}
