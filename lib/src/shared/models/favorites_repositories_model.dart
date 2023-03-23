import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/app/module/repositories/favorites_repositories/models/favorite_repository_model.dart';
import 'package:a3data_challenge/src/shared/models/repositories_model.dart';

class FavoritesRepositoriesModel extends RepositoriesModel {
  FavoritesRepositoriesModel._();
  static final instance = FavoritesRepositoriesModel._();

  @override
  void populateListOfRepositories({required List<RepositoryEntity> list}) {
    mainList.clear();
    for (final repositoryEntity in list) {
      mainList.add(
        FavoriteRepositoryModel(
          id: repositoryEntity.id,
          name: repositoryEntity.name,
          description: repositoryEntity.description,
          creationDate: repositoryEntity.creationDate,
          language: repositoryEntity.language,
          watchers: repositoryEntity.watchers,
          isFavorite: repositoryEntity.isFavorite,
        ),
      );
    }
  }

  void removeFavoriteFromList({required FavoriteRepositoryModel unfavored}) {
    mainList.removeWhere(
      (favorite) => favorite.id == unfavored.id,
    );
  }
}
