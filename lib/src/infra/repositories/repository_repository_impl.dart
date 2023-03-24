import 'package:flutter/material.dart';

import 'package:a3data_challenge/src/core/constants/keys_constants.dart';
import 'package:a3data_challenge/src/core/enums/status_enum.dart';
import 'package:a3data_challenge/src/domain/entities/language_entity.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:a3data_challenge/src/infra/drivers/database.dart';
import 'package:a3data_challenge/src/shared/utils/map_tricks.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final Database database;

  RepositoryRepositoryImpl({
    required this.database,
  });

  @override
  Future<List<RepositoryEntity>> getListFavoritesFromDatabase() async {
    final favoritesDatabase = await database.getItem(
      key: KeysConstants.itemsKey,
    );
    final listFavoritesMap = MapTricks.convertDynamicToListMap(
      favoritesDatabase,
    );

    final listFavorites = <RepositoryEntity>[];

    listFavoritesMap.map(
      (favoriteMap) async {
        listFavorites.add(
          RepositoryEntity(
            id: favoriteMap["id"],
            name: favoriteMap["name"],
            description: favoriteMap["description"],
            creationDate: DateTime.parse(favoriteMap["creationDate"]).toLocal(),
            language: LanguageEntity(
              name: favoriteMap["language"]["name"],
              color: Color(favoriteMap["language"]["color"]),
            ),
            watchers: favoriteMap["watchers"],
            isFavorite: favoriteMap["isFavorite"],
          ),
        );
      },
    ).toList();
    return listFavorites;
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
          listFavorites[favoriteIndex].language.name !=
              modifiedFavorite.language.name ||
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
            "language": {
              "name": favorite.language.name,
              "color": favorite.language.color.value,
            },
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

  @override
  Future<StatusEnum> removeFavoriteInDatabase({
    required RepositoryEntity unfavored,
  }) async {
    try {
      final listFavorites = await getListFavoritesFromDatabase();
      listFavorites.removeWhere((favorite) => favorite.id == unfavored.id);
      final listFavoritesMap = listFavorites
          .map(
            (favorite) => <String, dynamic>{
              "id": favorite.id,
              "name": favorite.name,
              "description": favorite.description,
              "creationDate": favorite.creationDate.toIso8601String(),
              "language": {
                "name": favorite.language.name,
                "color": favorite.language.color.value,
              },
              "watchers": favorite.watchers,
              "isFavorite": favorite.isFavorite,
            },
          )
          .toList();
      await database.setItem(
        key: KeysConstants.itemsKey,
        data: listFavoritesMap,
      );
      return StatusEnum.success;
    } catch (e) {
      return StatusEnum.error;
    }
  }
}
