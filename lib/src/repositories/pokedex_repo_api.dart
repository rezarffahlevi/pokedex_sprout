

abstract class PokedexRepoApi {
  Future<List<int>> getAllIds();
  Future<Map<String, dynamic>> getDetail(int id);
}
