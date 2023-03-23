import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/public_repository_model.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/shared/models/repositories_model.dart';

class PublicRepositoriesModel extends RepositoriesModel {
  PublicRepositoriesModel(super.value);

  @override
  void populateListOfRepositories({required List<RepositoryEntity> list}) {
    value.clear();
    for (final repositoryEntity in list) {
      value.add(
        PublicRepositoryModel(
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
}
