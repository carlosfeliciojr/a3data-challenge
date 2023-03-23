abstract class Database {
  Future<void> init();

  Future<Map<String, dynamic>?> getItem({required String key});

  Future<void> setItem({
    required String key,
    required dynamic data,
  });

  Future<void> removeItem({required String key});

  Future<void> clear();
}
