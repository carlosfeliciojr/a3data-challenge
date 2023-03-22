import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/services/repository_services.dart';

class GetListOfUserRepositoriesUseCase {
  GetListOfUserRepositoriesUseCase({required this.repository});

  final RepositoryServices repository;

  Future<List<RepositoryEntity>> call({
    required String username,
  }) async {
    final listOfRepositories = await repository.getListOfUserRepositories(
      username: username,
    );
    return listOfRepositories;
  }
}
