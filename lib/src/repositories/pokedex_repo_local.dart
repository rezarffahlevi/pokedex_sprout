import 'package:pokedex_sprout/src/models/pokedex_model.dart';

abstract class PokedexRepoLocal {
  Future<List<PokedexModel>> getList({int page, int limit});
  Future<int> upsert(Map<String, dynamic> data);
}
