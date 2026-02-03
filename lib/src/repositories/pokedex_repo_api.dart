

import 'package:pokedex_sprout/src/models/pokedex_model.dart';

abstract class PokedexRepoApi {
  Future<List<PokedexModel>> getList({int page = 1, int limit = 15});
  Future<PokedexModel> getDetail(int id);
}
