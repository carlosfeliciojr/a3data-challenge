import 'package:a3data_challenge/src/core/constants/keys_constants.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:a3data_challenge/src/infra/data_source/database.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final Database database;

  RepositoryRepositoryImpl({required this.database});

  @override
  Future<List<Map<String, dynamic>>> getListFavoritesFromDatabase() async {
    final favoritesDatabase = await database.getItem(
          key: KeysConstants.itemsKey,
        ) ??
        {
          KeysConstants.listFavoritesKey: [],
        };
    final listFavorites = List<Map<String, dynamic>>.from(
      favoritesDatabase[KeysConstants.listFavoritesKey],
    );
    return listFavorites;
  }

  @override
  Future<Map<String, dynamic>> updateRepositoryInDatabase({
    required Map<String, dynamic> favorite,
  }) async {
    final listFavorites = await getListFavoritesFromDatabase();
    final favoriteIndex = listFavorites.indexWhere(
      (repository) => repository["id"] == favorite["id"],
    );
    listFavorites[favoriteIndex] = favorite;

    await saveRepositoryInDatabase(newFavorite: listFavorites[favoriteIndex]);

    return favorite;
  }

  @override
  Future<void> saveRepositoryInDatabase({
    required Map<String, dynamic> newFavorite,
  }) async {
    final listFavorites = await getListFavoritesFromDatabase();
    listFavorites.add(newFavorite);
    await database.setItem(
      key: KeysConstants.itemsKey,
      data: {KeysConstants.listFavoritesKey: listFavorites},
    );
  }
}
