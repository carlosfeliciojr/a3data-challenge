import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/shared/models/repository_model.dart';

abstract class RepositoriesModel {
  final mainList = <RepositoryModel>[];

  List<RepositoryModel> get list {
    return [...mainList];
  }

  int get lenght {
    return list.length;
  }

  bool get isEmpty {
    return list.isEmpty;
  }

  void updateRepository({
    required RepositoryModel modifiedRepository,
  }) {
    final repositoryIndex = mainList.indexWhere(
      (repository) => repository.id == modifiedRepository.id,
    );
    if (repositoryIndex != -1) {
      mainList[repositoryIndex] = modifiedRepository;
    }
  }

  void populateListOfRepositories({
    required List<RepositoryEntity> list,
  });
}
