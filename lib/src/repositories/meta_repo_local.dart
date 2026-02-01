
abstract class MetaRepoLocal {
  Future<int> set(String key, String value);
  Future<String?> get(String key);
}
