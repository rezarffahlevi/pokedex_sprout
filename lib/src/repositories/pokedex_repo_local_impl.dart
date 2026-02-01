import 'dart:convert';
import 'package:pokedex_sprout/src/models/pokedex_model.dart';
import 'package:pokedex_sprout/src/repositories/pokedex_repo_local.dart';
import 'package:pokedex_sprout/src/utils/app_database.dart';
import 'package:sqflite/sqflite.dart';

class PokedexRepoLocalImpl extends PokedexRepoLocal {
  Future<Database> get db async => AppDatabase.db;

  PokedexRepoLocalImpl();

  Future<List<PokedexModel>> getList({int page = 1, int limit = 15}) async {
    final database = await db;
    final offset = (page - 1) * limit;
    final res = await database.query(
      'pokemons',
      orderBy: 'id ASC',
      offset: offset,
      limit: limit,
    );

    return res.map((e) => PokedexModel.fromMap(e)).toList();
  }

  @override
  Future<int> upsert(Map<String, dynamic> data) async {
    final database = await db;

    int stat(String name) =>
        data['stats'].firstWhere((e) => e['stat']['name'] == name)['base_stat'];

    return await database.insert('pokemons', {
      'id': data['id'],
      'name': data['name'],
      'image': data['sprites']['other']['official-artwork']['front_default'],
      'primary_type': data['types'][0]['type']['name'],
      'secondary_type': data['types'].length > 1
          ? data['types'][1]['type']['name']
          : null,
      'height': data['height'],
      'weight': data['weight'],
      'species': data['species']['name'],
      'abilities': (data['abilities'] as List)
          .map((e) => e['ability']['name'])
          .join(','),
      'hp': stat('hp'),
      'attack': stat('attack'),
      'defense': stat('defense'),
      'sp_attack': stat('special-attack'),
      'sp_defense': stat('special-defense'),
      'speed': stat('speed'),
      'raw_json': jsonEncode(data),
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
