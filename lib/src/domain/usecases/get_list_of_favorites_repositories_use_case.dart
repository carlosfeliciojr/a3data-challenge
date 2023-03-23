import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';
import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';

class GetListOfFavoritesRepositoriesUseCase {
  GetListOfFavoritesRepositoriesUseCase({required this.repository});

  final RepositoryRepository repository;

  Future<List<RepositoryEntity>> call() async {
    final listOfRepositories = await repository.getListFavoritesFromDatabase();
    return listOfRepositories;
  }
}
