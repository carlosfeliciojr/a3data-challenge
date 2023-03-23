import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';

class UpdateListOfRepositoriesWithFavoritesUseCase {
  UpdateListOfRepositoriesWithFavoritesUseCase();

  List<RepositoryEntity> call({
    required List<RepositoryEntity> repositories,
    required List<RepositoryEntity> favorites,
  }) {
    for (final repository in repositories) {
      for (final favorite in favorites) {
        if (repository.id == favorite.id) {
          repository.isFavorite = true;
        }
      }
    }
    return repositories;
  }
}
