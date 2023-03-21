import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/params/get_list_of_repositories_params.dart';

abstract class RepositoryRepository {
  Future<List<RepositoryEntity>> getListOfRepositories({
    required GetListOfRepositoriesParams params,
  });
}
