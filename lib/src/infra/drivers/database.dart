abstract class Database {
  Future<void> init();

  Future<dynamic> getItem({required String key});

  Future<bool> setItem({
    required String key,
    required dynamic data,
  });

  Future<bool> removeItem({required String key});

  Future<bool> clear();
}
