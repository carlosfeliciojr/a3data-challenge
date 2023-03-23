import 'package:a3data_challenge/src/app/module/repositories/list_repositories/models/repository_model.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';

class RepositoriesModel {
  final _listOfRepositories = <RepositoryModel>[];

  List<RepositoryModel> get listOfRepositories {
    return [..._listOfRepositories];
  }

  int get lenght {
    return listOfRepositories.length;
  }

  bool get isEmpty {
    return listOfRepositories.isEmpty;
  }

  void updateRepository({
    required RepositoryModel modifiedRepository,
  }) {
    final repositoryIndex = _listOfRepositories.indexWhere(
      (repository) => repository.id == modifiedRepository.id,
    );
    if (repositoryIndex != -1) {
      _listOfRepositories[repositoryIndex] = modifiedRepository;
    }
  }

  void populateListOfRepositories({
    required List<RepositoryEntity> listOfRepositories,
  }) {
    _listOfRepositories.clear();
    for (final repositoryEntity in listOfRepositories) {
      _listOfRepositories.add(
        RepositoryModel.fromEntity(entity: repositoryEntity),
      );
    }
  }
}
