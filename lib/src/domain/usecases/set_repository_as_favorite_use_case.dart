import 'package:a3data_challenge/src/core/enums/status_enum.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';

class SetRepositoryAsFavoriteUseCase {
  SetRepositoryAsFavoriteUseCase({required this.repository});

  final RepositoryRepository repository;

  Future<StatusEnum> call({
    required RepositoryEntity repository,
  }) async {
    final listFavorites = await this.repository.getListFavoritesFromDatabase();
    final newFavorite = _convertRepositoryEntityToMap(repository: repository);

    if (_favoriteAlreadyExist(
      listFavorites: listFavorites,
      newFavorite: newFavorite,
    )) {
      return StatusEnum.none;
    } else if (_favoriteNeedUpdate(
      listFavorites: listFavorites,
      newFavorite: newFavorite,
    )) {
      this.repository.updateRepositoryInDatabase(favorite: newFavorite);
      return StatusEnum.updated;
    } else {
      await this.repository.saveRepositoryInDatabase(newFavorite: newFavorite);
      return StatusEnum.success;
    }
  }

  Map<String, dynamic> _convertRepositoryEntityToMap({
    required RepositoryEntity repository,
  }) {
    final newFavorite = <String, dynamic>{
      "id": repository.id,
      "name": repository.name,
      "description": repository.description,
      "creationDate": repository.creationDate.toIso8601String(),
      "language": repository.language.text,
      "watchers": repository.watchers,
    };
    return newFavorite;
  }

  _favoriteAlreadyExist({
    required List<Map<String, dynamic>> listFavorites,
    required Map<String, dynamic> newFavorite,
  }) {
    return listFavorites.any(
      (favorite) {
        if (favorite.length != newFavorite.length) {
          return false;
        }

        for (final key in favorite.keys) {
          if (!newFavorite.containsKey(key) ||
              favorite[key] != newFavorite[key]) {
            return false;
          }
        }

        return true;
      },
    );
  }

  bool _favoriteNeedUpdate({
    required List<Map<String, dynamic>> listFavorites,
    required Map<String, dynamic> newFavorite,
  }) {
    return listFavorites.any(
      (favorite) {
        return favorite["id"] == newFavorite["id"];
      },
    );
  }
}
