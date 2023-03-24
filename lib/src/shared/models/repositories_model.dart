import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/shared/models/repository_model.dart';
import 'package:flutter/foundation.dart';

abstract class RepositoriesModel extends ValueNotifier {
  RepositoriesModel(super.value);

  @override
  final value = <RepositoryModel>[];

  List<RepositoryModel> get list {
    return [...value];
  }

  int get length {
    return list.length;
  }

  bool get isEmpty {
    return list.isEmpty;
  }

  void updateRepository({
    required RepositoryModel modifiedRepository,
  }) {
    final repositoryIndex = value.indexWhere(
      (repository) => repository.id == modifiedRepository.id,
    );
    if (repositoryIndex != -1) {
      value[repositoryIndex] = modifiedRepository;
    }
    notifyListeners();
  }

  void populateListOfRepositories({
    required List<RepositoryEntity> list,
  });
}
