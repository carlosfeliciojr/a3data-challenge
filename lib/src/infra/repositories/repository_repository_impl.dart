import 'package:a3data_challenge/src/core/constants/keys_constants.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/enums/code_language_enum.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:a3data_challenge/src/infra/data_source/database.dart';
import 'package:a3data_challenge/src/shared/utils/map_tricks.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final Database database;

  RepositoryRepositoryImpl({required this.database});

  @override
  Future<List<RepositoryEntity>> getListFavoritesFromDatabase() async {
    final favoritesDatabase = await database.getItem(
      key: KeysConstants.itemsKey,
    );
    final listFavorites = MapTricks.convertDynamicToListMap(
      favoritesDatabase,
    );
    return listFavorites
        .map(
          (favorite) => RepositoryEntity(
            id: favorite["id"],
            name: favorite["name"],
            description: favorite["description"],
            creationDate: DateTime.parse(favorite["creationDate"]).toLocal(),
            language: CodeLanguageEnum.fromText(text: favorite["language"]),
            watchers: favorite["watchers"],
            isFavorite: favorite["isFavorite"],
          ),
        )
        .toList();
  }

  @override
  Future<RepositoryEntity?> updateRepositoryInDatabase({
    required RepositoryEntity modifiedFavorite,
  }) async {
    final listFavorites = await getListFavoritesFromDatabase();
    final favoriteIndex = listFavorites.indexWhere(
      (repository) => repository.id == modifiedFavorite.id,
    );
    if (favoriteIndex != -1) {
      final needUpdate = listFavorites[favoriteIndex].name !=
              modifiedFavorite.name ||
          listFavorites[favoriteIndex].description !=
              modifiedFavorite.description ||
          listFavorites[favoriteIndex].creationDate !=
              modifiedFavorite.creationDate ||
          listFavorites[favoriteIndex].language != modifiedFavorite.language ||
          listFavorites[favoriteIndex].watchers != modifiedFavorite.watchers ||
          listFavorites[favoriteIndex].isFavorite !=
              modifiedFavorite.isFavorite;
      if (needUpdate) {
        await saveRepositoryInDatabase(
            newFavorite: listFavorites[favoriteIndex]);

        return modifiedFavorite;
      }
    }
    return null;
  }

  @override
  Future<void> saveRepositoryInDatabase({
    required RepositoryEntity newFavorite,
  }) async {
    final listFavorites = await getListFavoritesFromDatabase();
    listFavorites.add(newFavorite);
    final listFavoritesMap = listFavorites
        .map(
          (favorite) => <String, dynamic>{
            "id": favorite.id,
            "name": favorite.name,
            "description": favorite.description,
            "creationDate": favorite.creationDate.toIso8601String(),
            "language": favorite.language.text,
            "watchers": favorite.watchers,
            "isFavorite": favorite.isFavorite,
          },
        )
        .toList();
    await database.setItem(
      key: KeysConstants.itemsKey,
      data: listFavoritesMap,
    );
  }
}
