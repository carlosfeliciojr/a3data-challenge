import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:a3data_challenge/src/infra/requests/get_list_of_repositories_request.dart';
import 'package:a3data_challenge/src/infra/services/repository_services.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final RepositoryServices services;

  RepositoryRepositoryImpl({required this.services});

  @override
  Future<List<RepositoryEntity>> getListOfRepositories({
    required GetListOfRepositoriesParams params,
  }) async {
    final listRepository = await services.getListOfRepositories(
      request: GetListOfRepositoriesRequest.fromParams(params: params),
    );
    return listRepository
        .map(
          (repository) => RepositoryEntity(
            name: repository.name,
            description: repository.description,
            creationDate: repository.creationDate,
            language: repository.language,
            watchers: repository.watchers,
          ),
        )
        .toList();
  }
}
