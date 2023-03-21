import 'package:a3data_challenge/src/domain/repositories/repository_repository.dart';
import 'package:a3data_challenge/src/infra/data_source/local_database.dart';

class RepositoryRepositoryImpl implements RepositoryRepository {
  final LocalDatabase database;

  RepositoryRepositoryImpl({required this.database});

  @override
  Future<void> getFavoritesRepositories() {
    // TODO: implement getFavoritesRepositories
    throw UnimplementedError();
  }

  @override
  Future<void> saveFavoriteRepository() {
    // TODO: implement saveFavoriteRepository
    throw UnimplementedError();
  }
}
