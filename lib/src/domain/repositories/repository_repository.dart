abstract class RepositoryRepository {
  Future<List<Map<String, dynamic>>> getListFavoritesFromDatabase();

  Future<void> saveRepositoryInDatabase({
    required Map<String, dynamic> newFavorite,
  });

  Future<Map<String, dynamic>> updateRepositoryInDatabase({
    required Map<String, dynamic> favorite,
  });
}
