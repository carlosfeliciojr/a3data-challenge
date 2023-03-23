import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/services/repository_services.dart';

class GetListOfUserRepositoriesUseCase {
  GetListOfUserRepositoriesUseCase({required this.services});

  final RepositoryServices services;

  Future<List<RepositoryEntity>> call({
    required String username,
  }) async {
    final listOfRepositories = await services.getListOfUserRepositories(
      username: username,
    );
    return listOfRepositories;
  }
}
