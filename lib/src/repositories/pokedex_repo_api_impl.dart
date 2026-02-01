import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_api.dart';
class PokedexRepoApiImpl extends PokedexRepoApi {
  final Dio dio;

  PokedexRepoApiImpl({required this.dio});

  @override
  Future<List<int>> getAllIds() async {
    final res = await dio.get('/api/v2/pokemon', queryParameters: {'limit': 2000});

    return (res.data['results'] as List).map((e) {
      final uri = Uri.parse(e['url']);
      return int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
    }).toList();
  }

  @override
  Future<Map<String, dynamic>> getDetail(int id) async {
    final res = await dio.get('/api/v2/pokemon/$id/');
    return res.data;
  }
}
