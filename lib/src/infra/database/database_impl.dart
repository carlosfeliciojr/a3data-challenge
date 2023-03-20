import '../data_source/local_data_source.dart';
import '../models/repository_model.dart';
import 'database.dart';

class DatabaseImpl implements Database {
  final LocalDataSource localDataSource;

  DatabaseImpl({required this.localDataSource});

  @override
  Future<bool> saveFavoritesRepositories({
    required RepositoryModel repository,
  }) {
    // TODO: implement saveFavoritesRepositories
    throw UnimplementedError();
  }
}
