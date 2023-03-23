import 'package:a3data_challenge/src/core/enums/status_enum.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';

class SetRepositoryAsFavoriteUseCase {
  SetRepositoryAsFavoriteUseCase({required this.repository});

  final RepositoryRepository repository;

  Future<StatusEnum> call({
    required RepositoryEntity newFavorite,
  }) async {
    final listFavorites = await repository.getListFavoritesFromDatabase();

    if (_newFavoriteAlreadyExist(
      listFavorites: listFavorites,
      newFavorite: newFavorite,
    )) {
      return StatusEnum.none;
    } else if (_favoriteNeedsUpdate(
      listFavorites: listFavorites,
      newFavorite: newFavorite,
    )) {
      repository.updateRepositoryInDatabase(modifiedFavorite: newFavorite);
      return StatusEnum.updated;
    } else {
      await repository.saveRepositoryInDatabase(newFavorite: newFavorite);
      return StatusEnum.success;
    }
  }

  bool _newFavoriteAlreadyExist({
    required List<RepositoryEntity> listFavorites,
    required RepositoryEntity newFavorite,
  }) {
    return listFavorites.any((favorite) =>
        favorite.name == newFavorite.name &&
        favorite.id == newFavorite.id &&
        favorite.description == newFavorite.description &&
        favorite.creationDate == newFavorite.creationDate &&
        favorite.language == newFavorite.language &&
        favorite.watchers == newFavorite.watchers &&
        favorite.isFavorite == newFavorite.isFavorite);
  }

  bool _favoriteNeedsUpdate({
    required List<RepositoryEntity> listFavorites,
    required RepositoryEntity newFavorite,
  }) {
    return listFavorites.any((favorite) => favorite.id == newFavorite.id);
  }
}
