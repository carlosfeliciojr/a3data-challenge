import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repositories.dart';
import 'package:a3data_challenge/src/infra/services/repository_services.dart';

class RepositoryRepositoriesImpl implements RepositoryRepositories {
  final RepositoryServices services;

  RepositoryRepositoriesImpl(this.services);

  @override
  Future<RepositoryEntity> getListOfRepositories() {
    return services.getListOfRepositories();
  }
}
