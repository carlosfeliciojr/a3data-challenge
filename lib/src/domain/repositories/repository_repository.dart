import 'package:a3data_challenge/src/core/enums/status_enum.dart';
import 'package:a3data_challenge/src/domain/entities/repository_entity.dart';

abstract class RepositoryRepository {
  Future<List<RepositoryEntity>> getListFavoritesFromDatabase();

  Future<void> saveRepositoryInDatabase({
    required RepositoryEntity newFavorite,
  });

  Future<RepositoryEntity?> updateRepositoryInDatabase({
    required RepositoryEntity modifiedFavorite,
  });

  Future<StatusEnum> removeFavoriteInDatabase({
    required RepositoryEntity unfavored,
  });
}
