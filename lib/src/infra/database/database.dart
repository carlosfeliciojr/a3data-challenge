import '../models/repository_model.dart';

abstract class Database {
  Future<bool> saveFavoritesRepositories({required RepositoryModel repository});
}
