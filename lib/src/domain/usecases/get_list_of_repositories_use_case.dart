import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';

class GetListOfRepositoriesUseCase {
  GetListOfRepositoriesUseCase({required this.repository});

  final RepositoryRepository repository;

  Future<List<RepositoryEntity>> call({
    required GetListOfRepositoriesParams params,
  }) async {
    final listOfRepositories = await repository.getListOfRepositories(
      params: params,
    );
    return listOfRepositories;
  }
}
