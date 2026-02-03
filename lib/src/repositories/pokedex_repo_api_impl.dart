import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_api.dart';

class PokedexRepoApiImpl extends PokedexRepoApi {
  final Dio dio;

  PokedexRepoApiImpl({required this.dio});
  @override
  Future<List<PokedexModel>> getList({int page = 1, int limit = 15}) async {
    final offset = (page - 1) * limit;
    final res = await dio.get(
      '/api/v2/pokemon',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    return (res.data['results'] as List).map((e) {
      final uri = Uri.parse(e['url']);
      final id = int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
      return PokedexModel(id: id, name: e['name']);
    }).toList();
  }

  @override
  Future<PokedexModel> getDetail(int id) async {
    final res = await dio.get('/api/v2/pokemon/$id/');
    return PokedexModel.fromMap(res.data);
  }
}
