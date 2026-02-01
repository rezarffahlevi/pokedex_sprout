import 'package:pokedex_sprout/src/repositories/meta_repo_local.dart';
import 'package:pokedex_sprout/src/utils/app_database.dart';
import 'package:sqflite/sqflite.dart';

class MetaRepoLocalImpl extends MetaRepoLocal {
  Future<Database> get db async => AppDatabase.db;

  MetaRepoLocalImpl();

  Future<int> set(String key, String value) async {
    final database = await db;
    return await database.insert('meta', {
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<String?> get(String key) async {
    final database = await db;
    final res = await database.query('meta', where: 'key = ?', whereArgs: [key]);
    if (res.isEmpty) return null;
    return res.first['value'] as String?;
  }
}
