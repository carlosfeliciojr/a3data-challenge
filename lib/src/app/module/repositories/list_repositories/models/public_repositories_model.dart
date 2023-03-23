import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/public_repository_model.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/shared/models/repositories_model.dart';

class PublicRepositoriesModel extends RepositoriesModel {
  PublicRepositoriesModel();

  @override
  void populateListOfRepositories({required List<RepositoryEntity> list}) {
    mainList.clear();
    for (final repositoryEntity in list) {
      mainList.add(
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
