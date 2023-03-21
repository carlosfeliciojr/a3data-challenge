import 'package:a3data_challenge/src/infra/models/repository_model.dart';
import 'package:a3data_challenge/src/infra/requests/get_list_of_repositories_request.dart';

abstract class RepositoryServices {
  Future<List<RepositoryModel>> getListOfRepositories({
    required GetListOfRepositoriesRequest request,
  });
}
